class Myad < ActiveRecord::Base
  belongs_to :typead
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: ->(image) { image[:url].blank? }, allow_destroy: true
  self.per_page = 10
  validates :typead_id, presence: true
  validates :title, presence: true, length: { in: 10..100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true

  scope :including, -> { includes(:typead, :images, :user) }

  state_machine initial: :drafting do
    state :drafting,  value: 0
    state :freshing,  value: 1
    state :rejected,  value: 2
    state :approved,  value: 3
    state :published, value: 4
    state :archives,   value: 5
    state :banned,    value: 6

    event :draft do
      transition [:rejected, :archives] => :drafting
    end
    event :fresh do
      transition drafting: :freshing
    end

    event :reject do
      transition freshing: :rejected
    end

    event :approve do
      transition freshing: :approved
    end

    event :publish do
      transition approved: :published
    end

    event :archive do
      transition published: :archives
    end

    event :ban do
      transition freshing: :banned
    end

  end

  def self.admin_events
    [:reject, :approve, :ban]
  end

  def self.user_events
    [:draft, :fresh]
  end

  def self.admin_state
    [1, 2, 3, 4, 6]
  end

  def self.update_ads
    ads = Myad.with_state(:approved)
    ads.reduce(0) { |a, e| a + (e.publish ? 1 : 0) }
  end

  def self.updete_published
    ads = Myad.with_state(:published)
    archive = lambda do |ad|
      flag = ad.updated_at + 3.day - Time.new > 0 ? true : false
      return ad.archive unless flag
      flag
    end
    ads.reduce(0) { |a, e| a + (archive.call(e) ? 0 : 1) }
  end
end
