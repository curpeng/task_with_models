class Item < ActiveRecord::Base
  attr_accessible :description, :item_id, :name, :price
  has_many :transactions
  has_many :orders,:through=>:transactions
  validates :name,:price,:presence=>true
end
