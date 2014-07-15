class Typead < ActiveRecord::Base
  has_many :myads, dependent: :destroy
  validates :name, presence: true, length: { in: 10..100 }
  validates :description, presence: true, length: { maximum: 500 }
end
