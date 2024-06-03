require "test_helper"

class InitialQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get initial_questions_index_url
    assert_response :success
  end

  test "should get show" do
    get initial_questions_show_url
    assert_response :success
  end

  test "should get new" do
    get initial_questions_new_url
    assert_response :success
  end

  test "should get create" do
    get initial_questions_create_url
    assert_response :success
  end
end
