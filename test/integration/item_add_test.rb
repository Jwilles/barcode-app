require 'test_helper'

class ItemAddTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:mike)
  end

  ## Invalid submission of upc currently not handled

  test "invalid add information" do
    log_in_as(@user)
    get new_item_path
    assert_no_difference 'Item.count' do 
      post items_path, params: { method: "add", upc: "  "} 
    end
    assert_redirected_to items_path 
    follow_redirect!
  end


  test "valid add information" do
    log_in_as(@user)
    get new_item_path
    assert_difference 'Item.count' do 
      post items_path, params: { method: "add", upc: "058807422839"} 
    end
    assert_redirected_to items_path 
    follow_redirect!
  end

end
