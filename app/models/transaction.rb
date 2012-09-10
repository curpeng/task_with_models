class Transaction < ActiveRecord::Base
  attr_accessible :item_id, :order_id, :transaction_id
  belongs_to :order
  belongs_to :item
end
