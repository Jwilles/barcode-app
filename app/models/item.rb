class Item < ApplicationRecord

  validates :upc, presence: true
  validates :name, presence: true
  
  before_save { self.name = name.upcase }

end
