require 'test_helper'

class <%= controller_class_name %>ControllerTest < ActionDispatch::IntegrationTest
  setup do
    @<%= nested_parent_name %> = <%= plural_nested_parent_name %>(:one)
    @<%= singular_table_name %> = <%= table_name %>(:one)
  end

  test "should get index" do
    get <%= nested_parent_name %>_<%= index_helper %>_url(@<%= nested_parent_name %>)
    assert_response :success
  end

  test "should get new" do
    get new_<%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>)
    assert_response :success
  end

  test "should create <%= singular_table_name %>" do
    assert_difference('<%= class_name %>.count') do
      post <%= nested_parent_name %>_<%= index_helper %>_url(@<%= nested_parent_name %>), params: { <%= singular_table_name %>: @<%= singular_table_name %>.attributes }
    end

    assert_redirected_to <%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, <%= class_name %>.last)
  end

  test "should show <%= singular_table_name %>" do
    get <%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, @<%= singular_table_name %>)
    assert_response :success
  end

  test "should get edit" do
    get edit_<%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, @<%= singular_table_name %>)
    assert_response :success
  end

  test "should update <%= singular_table_name %>" do
    patch <%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, @<%= singular_table_name %>), params: { <%= singular_table_name %>: @<%= singular_table_name %>.attributes }
    assert_redirected_to <%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, <%= class_name %>.last)
  end

  test "should destroy <%= singular_table_name %>" do
    assert_difference('<%= class_name %>.count', -1) do
      delete <%= nested_parent_name %>_<%= singular_table_name %>_url(@<%= nested_parent_name %>, @<%= singular_table_name %>)
    end

    assert_redirected_to <%= nested_parent_name %>_<%= index_helper %>_url(@<%= nested_parent_name %>)
  end
end
