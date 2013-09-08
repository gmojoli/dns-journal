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

    def do_update(attrs)
      put :update, {:domain_id => @dns_zone.domain.slug, :id => @dns_zone.id, :dns_zone => attrs}
    end

    context "with an existing domain and a dns_zone" do

      it "create a new dns_zone when updating" do
        lambda do
          do_update @attr
        end.should change(DnsZone, :count).by(1)
        @dns_zone[:origin].should eq 'foo.com'
        DnsZone.last[:origin].should eq @attr[:origin]
      end

      it "create a dup for every resouce_record" do
        lambda do
          do_update @attr
        end.should change(ResourceRecord, :count).by(@dns_zone.resource_records.count)
      end

      it "create a dup for a soa section" do
        lambda do
          do_update @attr
        end.should change(SoaSection, :count).by(1)
      end
    end

    context 'updating a dns_zone with invalid attributes' do
      it 'rerender the edit template' do
        invalid_attrs = { :origin => "bar.com", :ttl => "11", :admin_email => 'invalid[at]email.com' }
        do_update invalid_attrs
        response.should render_template('edit')
        flash[:alert].should match("failed")
      end
    end

  end
end
