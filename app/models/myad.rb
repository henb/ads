class Myad < ActiveRecord::Base
  belongs_to :typead

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

    event :fresh do
      transition :drafting => :freshing   
    end

    event :reject do
      transition :freshing => :rejected   
    end

    event :approve do
      transition :freshing => :approve   
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
    
    event :draft do
      transition :archives => :drafting   
    end
  end

end
