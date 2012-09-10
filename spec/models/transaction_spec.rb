require 'spec_helper'

describe Transaction do
  it {should belong_to(:order)}
  it {should belong_to(:item)}
end
