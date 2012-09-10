require 'spec_helper'

describe Order do
  it { should belong_to(:customer) }
  it { should have_many(:items).through(:transactions) }
  it "shouldn't validate without items" do
    customer=Customer.create(:name => "first_customer", :email => "asd@mail.ru")
    order=Order.new(:customer_id => customer.id)
    order.items.build(:name => "item", :price => 1.00)
    order.save
  end
end
