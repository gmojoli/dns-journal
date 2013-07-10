require 'test_helper'

class ResourceRecordsControllerTest < ActionController::TestCase
  setup do
    @resource_record = resource_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resource_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource_record" do
    assert_difference('ResourceRecord.count') do
      post :create, resource_record: { description: @resource_record.description, rfc: @resource_record.rfc, type: @resource_record.type, value: @resource_record.value }
    end

    assert_redirected_to resource_record_path(assigns(:resource_record))
  end

  test "should show resource_record" do
    get :show, id: @resource_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resource_record
    assert_response :success
  end

  test "should update resource_record" do
    patch :update, id: @resource_record, resource_record: { description: @resource_record.description, rfc: @resource_record.rfc, type: @resource_record.type, value: @resource_record.value }
    assert_redirected_to resource_record_path(assigns(:resource_record))
  end

  test "should destroy resource_record" do
    assert_difference('ResourceRecord.count', -1) do
      delete :destroy, id: @resource_record
    end

    assert_redirected_to resource_records_path
  end
end
