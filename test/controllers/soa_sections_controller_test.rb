require 'test_helper'

class SoaSectionsControllerTest < ActionController::TestCase
  setup do
    @soa_section = soa_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:soa_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create soa_section" do
    assert_difference('SoaSection.count') do
      post :create, soa_section: { expire: @soa_section.expire, mname: @soa_section.mname, minimum: @soa_section.minimum, primary_domain_name: @soa_section.primary_domain_name, refresh: @soa_section.refresh, retry: @soa_section.retry, rname: @soa_section.rname, serial_number: @soa_section.serial_number, zone_class: @soa_section.zone_class }
    end

    assert_redirected_to soa_section_path(assigns(:soa_section))
  end

  test "should show soa_section" do
    get :show, id: @soa_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @soa_section
    assert_response :success
  end

  test "should update soa_section" do
    patch :update, id: @soa_section, soa_section: { expire: @soa_section.expire, mname: @soa_section.mname, minimum: @soa_section.minimum, primary_domain_name: @soa_section.primary_domain_name, refresh: @soa_section.refresh, retry: @soa_section.retry, rname: @soa_section.rname, serial_number: @soa_section.serial_number, zone_class: @soa_section.zone_class }
    assert_redirected_to soa_section_path(assigns(:soa_section))
  end

  test "should destroy soa_section" do
    assert_difference('SoaSection.count', -1) do
      delete :destroy, id: @soa_section
    end

    assert_redirected_to soa_sections_path
  end
end
