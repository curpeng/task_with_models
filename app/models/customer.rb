class Customer < ActiveRecord::Base
  attr_accessible :customer_id, :email, :name
  has_many :orders

  def self.finding_all_items_of_user(customer)
    orders=customer.orders
    items=Array.new
    orders.each { |order|
      items.concat(order.items)
    }
    items
  end

  def self.ranked_list(number)
    items_id=Transaction.group("item_id").limit(number)
    list=Array.new
    items_id.to_a.each { |transaction|
      list<<Item.find(transaction.item_id)
    }
    list
  end

  def self.customers_for_loyalty()
    loyalty_list=Array.new
    customers=Customer.all
    customers.each {
        |customer|
      items_count=0
      customer.orders.where("created_at >= ?", 9.months.ago).each {
          |order| items_count+=order.items.count
      }
      if items_count>=2
        loyalty_list<<customer
      end

    }
    loyalty_list
  end
end
