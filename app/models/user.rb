class User < ActiveRecord::Base
  extend Enumerize
  before_save { self.role = "user" if role!="admin"}

  has_many :myads, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: [:guest, :user, :admin], default: :guest

end
