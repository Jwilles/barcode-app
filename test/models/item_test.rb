require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.new(name: "Pasta Sauce", upc: "058807422839")
  end

  test "should be valid" do 
    assert @item.valid?
  end

  test "name should be present" do 
    @item.name = "    "
    assert_not @item.valid?
  end

  test "email should be present" do 
    @item.upc = "    "
    assert_not @item.valid?
  end


end
