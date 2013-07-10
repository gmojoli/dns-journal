require 'test_helper'

class DnsZonesControllerTest < ActionController::TestCase
  setup do
    @dns_zone = dns_zones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dns_zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dns_zone" do
    assert_difference('DnsZone.count') do
      post :create, dns_zone: { admin_email: @dns_zone.admin_email, description: @dns_zone.description, origin: @dns_zone.origin, ttl: @dns_zone.ttl, version: @dns_zone.version }
    end

    assert_redirected_to dns_zone_path(assigns(:dns_zone))
  end

  test "should show dns_zone" do
    get :show, id: @dns_zone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dns_zone
    assert_response :success
  end

  test "should update dns_zone" do
    patch :update, id: @dns_zone, dns_zone: { admin_email: @dns_zone.admin_email, description: @dns_zone.description, origin: @dns_zone.origin, ttl: @dns_zone.ttl, version: @dns_zone.version }
    assert_redirected_to dns_zone_path(assigns(:dns_zone))
  end

  test "should destroy dns_zone" do
    assert_difference('DnsZone.count', -1) do
      delete :destroy, id: @dns_zone
    end

    assert_redirected_to dns_zones_path
  end
end
