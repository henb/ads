class Typead < ActiveRecord::Base
	has_many :myads
    default_scope -> { order('name ASC') }
	validates :name, presence: true, length: { in:10..100 }
    validates :description, presence: true, length: { maximum:500 }
end
