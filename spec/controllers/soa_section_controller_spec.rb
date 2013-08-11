require 'spec_helper'

describe SoaSectionsController, :type => [:controller] do
  context "updating a soa_section" do

    before(:each) do
      @dns_zone = create(:dns_zone, :user => @user)
      @soa_section = @dns_zone.soa_section
    end

    it "increment also the revision value and the serial_number" do
      put :update, {:domain_id => @soa_section.dns_zone.domain.id, :dns_zone_id => @soa_section.dns_zone.id, :id => @soa_section.id,  :soa_section => {primary_domain_name: 'updated.foo.com'} }
      expect(@soa_section.primary_domain_name).to eq 'sample.com'
      old_serial_number = @soa_section.serial_number
      @soa_section.reload
      expect(@soa_section.primary_domain_name).to eq 'updated.foo.com'
      expect(@soa_section.revision).to eq 2
      expect(@soa_section.serial_number).to eq(old_serial_number + 1)
    end
  end
end
