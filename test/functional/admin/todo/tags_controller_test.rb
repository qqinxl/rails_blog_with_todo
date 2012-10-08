require 'test_helper'

class Admin::Todo::TagsControllerTest < ActionController::TestCase
  setup do
    @admin_todo_tag = admin_todo_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_todo_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_todo_tag" do
    assert_difference('Admin::Todo::Tag.count') do
      post :create, admin_todo_tag: { name: @admin_todo_tag.name, static: @admin_todo_tag.static }
    end

    assert_redirected_to admin_todo_tag_path(assigns(:admin_todo_tag))
  end

  test "should show admin_todo_tag" do
    get :show, id: @admin_todo_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_todo_tag
    assert_response :success
  end

  test "should update admin_todo_tag" do
    put :update, id: @admin_todo_tag, admin_todo_tag: { name: @admin_todo_tag.name, static: @admin_todo_tag.static }
    assert_redirected_to admin_todo_tag_path(assigns(:admin_todo_tag))
  end

  test "should destroy admin_todo_tag" do
    assert_difference('Admin::Todo::Tag.count', -1) do
      delete :destroy, id: @admin_todo_tag
    end

    assert_redirected_to admin_todo_tags_path
  end
end
