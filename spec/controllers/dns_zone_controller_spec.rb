require 'spec_helper'

describe DnsZonesController do

  describe "PUT 'update/:id'" do

    before(:each) do
      @user = create(:user)
      # @user.save
      @dns_zone = create(:dns_zone, :origin => 'foo.com', :user => @user)
      DnsZone.stub(:new_version).and_return(2)
      controller.stub(:current_user).and_return @user
    end

    it "create a new dns_zone when updating" do
      @attr = { :origin => "bar.com", :ttl => "11" }
      put :update, {:domain_id => @dns_zone.domain.id, :id => @dns_zone.id, :dns_zone => @attr}
      @dns_zone.reload

      @dns_zone[:origin].should_not eq @attr[:origin]
      @dns_zone[:origin].should eq 'foo.com'
      DnsZone.last[:origin].should eq @attr[:origin]
    end

  end
end
