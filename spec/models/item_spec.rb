require 'spec_helper'

describe Item do

  it { should have_many(:orders).through(:transactions) }
  it { should have_db_column(:name) }
  it { should have_db_column(:description) }
  it { should have_db_column(:price).of_type(:decimal).
                  with_options(:precision => 10, :scale => 2) }
  it "shouldn't validate within name" do
    item=Item.new(description: "smth", price: 1.00)
    item.should_not be_valid
  end
  it "shouldn't validate within price" do
    item=Item.new(name: "item", description: "item's description")
    item.should_not be_valid
  end
  it "should validate with name and price, even within description" do
    item=Item.new(name: "item", price: "3.33")
    item.should be_valid
  end
end
