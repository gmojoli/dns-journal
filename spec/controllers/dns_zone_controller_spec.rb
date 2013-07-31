require 'spec_helper'

describe DnsZonesController do

  describe "PUT 'update/:id'" do

    before(:each) do
      ResourceRecord.any_instance.stub(:valid?).and_return true
      @dns_zone = create(:dns_zone)
      @attr = { :origin => "bar.com", :ttl => "11" }
      @dns_zone.stub(:new_version).and_return(2)
      controller.stub(:authenticate_user!).and_return true
      controller.stub(:current_user).and_return @dns_zone.user
    end

    context "with an existing domain and a dns_zone" do
      it "respond to GET index" do
        get :index, {:domain_id => @dns_zone.domain}
        response.status.should eq 200
      end

      it "create a new dns_zone when updating" do
        lambda do
          put :update, {:domain_id => @dns_zone.domain.id, :id => @dns_zone.id, :dns_zone => @attr}
        end.should change(DnsZone, :count).by(1)
        @dns_zone[:origin].should_not eq @attr[:origin]
        @dns_zone[:origin].should eq 'foo.com'
        DnsZone.last[:origin].should eq @attr[:origin]
      end

      it "create a dup for every resouce_record" do
        lambda do
          put :update, {:domain_id => @dns_zone.domain.id, :id => @dns_zone.id, :dns_zone => @attr}
        end.should change(ResourceRecord, :count).by(@dns_zone.resource_records.count)
      end

    end

  end
end