require "test_helper"

class PrivateMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get private_messages_create_url
    assert_response :success
  end
end
