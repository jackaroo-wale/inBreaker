require "test_helper"

class InitialAnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get initial_answers_create_url
    assert_response :success
  end
end
