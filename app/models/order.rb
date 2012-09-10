class Order < ActiveRecord::Base
  attr_accessible :customer_id, :order_id
  belongs_to :customer
  has_many :transactions
  has_many :items,:through=>:transactions
  validates :items,:presence => true
end
