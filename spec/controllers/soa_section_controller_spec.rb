require 'spec_helper'

describe SoaSectionsController do
  context "updating a soa_section" do
    before do
      @soa_section = create(:soa_section, revision: 41)
    end
    it "increment the revision value" do
      put :update, {:domain_id => @soa_section.dns_zone.domain.id, :dns_zone_id => @soa_section.dns_zone.id, :id => @soa_section.id,  :soa_section => {primary_domain_name: 'foo.com'} }
      puts flash.inspect
      expect(@soa_section.revision).to eq 42
    end
  end
end
