require "test_helper"

class WeeklyAnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get weekly_answers_create_url
    assert_response :success
  end
end
