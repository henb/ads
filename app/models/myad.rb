class Myad < ActiveRecord::Base
  belongs_to :typead
  default_scope -> { order('updated_at DESC') }

  validates :typead_id, :presence => true
  validates :title, :presence => true, length: { minimum:10 }
  validates :description, :presence => true

  state_machine initial: :drafting do
    state :drafting,  value: 0 
    state :freshing,  value: 1
    state :rejected,  value: 2
    state :approved,  value: 3
    state :published, value: 4
    state :archives,   value: 5
    state :banned,    value: 6

    event :draft do
      transition [:rejected,:archives] => :drafting   
    end
    event :fresh do
      transition :drafting => :freshing   
    end

    event :reject do
      transition :freshing => :rejected   
    end

    event :approve do
      transition :freshing => :approved   
    end

    event :publish do
      transition :approved => :published   
    end

    event :archive do
      transition :published => :archives   
    end

    event :ban do
      transition :freshing => :banned   
    end

  end

  def admin_events

  end

  def user_events

  end

  def self.update_ads
    ads = Myad.with_state(:approved)
    ads.each {|ad| ad.publish }
  end

  def self.updete_published
    ads = Myad.with_state(:published)
    valide = proc { |ad| ad.updated_at + 3.day - Time.new > 0 ? true : false }
    
    ads.each { |ad| ad.archive unless valide.call ad }
  end
end
