require 'test_helper'

class Admin::Todo::ListsControllerTest < ActionController::TestCase
  setup do
    @admin_todo_list = admin_todo_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_todo_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_todo_list" do
    assert_difference('Admin::Todo::List.count') do
      post :create, admin_todo_list: { completed_at: @admin_todo_list.completed_at, deleted_at: @admin_todo_list.deleted_at, description: @admin_todo_list.description, due_date: @admin_todo_list.due_date, name: @admin_todo_list.name, starred: @admin_todo_list.starred }
    end

    assert_redirected_to admin_todo_list_path(assigns(:admin_todo_list))
  end

  test "should show admin_todo_list" do
    get :show, id: @admin_todo_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_todo_list
    assert_response :success
  end

  test "should update admin_todo_list" do
    put :update, id: @admin_todo_list, admin_todo_list: { completed_at: @admin_todo_list.completed_at, deleted_at: @admin_todo_list.deleted_at, description: @admin_todo_list.description, due_date: @admin_todo_list.due_date, name: @admin_todo_list.name, starred: @admin_todo_list.starred }
    assert_redirected_to admin_todo_list_path(assigns(:admin_todo_list))
  end

  test "should destroy admin_todo_list" do
    assert_difference('Admin::Todo::List.count', -1) do
      delete :destroy, id: @admin_todo_list
    end

    assert_redirected_to admin_todo_lists_path
  end
end
