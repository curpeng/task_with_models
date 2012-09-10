require 'spec_helper'
require 'database_cleaner'

describe Customer do

  it { should have_many (:orders) }
  it "ranked list" do
    customer=Customer.create(:name => "first_customer", :email => "asd@mail.ru")
    customer2=Customer.create(:name => "second_customer", :email => "second@mail.ru")
    customer3=Customer.create(:name => "third_customer", :email => "third@mail.ru")
    item=Item.create(:name => "item", :price => 1.00)
    item2=Item.create(:name => "item2", :price => 2.00)
    item3=Item.create(:name => "item3", :price => 3.00)
    order=Order.new(:customer_id => customer.id)
    order2=Order.new(:customer_id => customer.id)
    order3=Order.new(:customer_id => customer2.id)
    order4=Order.new(:customer_id => customer3.id)
    order.items<<item
    order2.items<<item
    order3.items<<item2
    order3.items<<item3
    order4.items<<item2
    order.save
    order2.save
    order3.save
    order4.save
    list=Customer.ranked_list(2)
    list.should be_a(Array)
    list.count.should ==2
    list.include?(item).should be_true
    list.include?(item2).should be_true
  end

  it "finding customers for a loyalty program" do

    customer=Customer.create(:name => "first_customer", :email => "asd@mail.ru")
    customer2=Customer.create(:name => "second_customer", :email => "second@mail.ru")
    customer3=Customer.create(:name => "third_customer", :email => "third@mail.ru")

    item=Item.create(:name => "item", :price => 1.00)
    item2=Item.create(:name => "item2", :price => 2.00)
    item3=Item.create(:name => "item3", :price => 3.00)

    order=Order.new(:customer_id => customer.id)
    order2=Order.new(:customer_id => customer.id)
    order3=Order.new(:customer_id => customer2.id)
    order4=Order.new(:customer_id => customer3.id)
    order.items<<item
    order2.items<<item
    order3.items<<item2
    order3.items<<item3
    order4.items<<item
    order.save
    order2.save
    order3.save
    order4.save
    loyalty_customers=Customer.customers_for_loyalty()
    loyalty_customers.should be_a(Array)
    loyalty_customers.count.should ==2
    loyalty_customers.include?(customer).should be_true
    loyalty_customers.include?(customer2).should be_true
  end

  it "finding all purchased items" do

    cust=Customer.create(:name => "someones", :email => "asd@asdas.coms")
    cust2=Customer.create(:name => "second_customer", :email => "second@mail.ru")
    order=Order.create(:customer_id => cust.id)
    order2=Order.create(:customer_id => cust.id)
    order3=Order.create(:customer_id => cust2.id)

    order.items.new(:name => "item5", :price => 8.00)
    order.items.new(:name => "item2", :price => 2.00)
    order2.items.new(:name => "item3", :price => 1.00)
    order3.items.new(:name => "item4", :price => 3.00)

    order.save
    order2.save
    order3.save
    customer_items=Customer.finding_all_items_of_user(cust)

    customer_items.should be_a(Array)
    customer_items.count.should ==3
    share_source= lambda { |item|
    customer_items.include?(item).should be true }
    order.items.each &share_source
    order2.items.each &share_source

  end


end
