require "test_helper"

class WeeklyQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weekly_questions_index_url
    assert_response :success
  end

  test "should get show" do
    get weekly_questions_show_url
    assert_response :success
  end

  test "should get new" do
    get weekly_questions_new_url
    assert_response :success
  end

  test "should get create" do
    get weekly_questions_create_url
    assert_response :success
  end
end
