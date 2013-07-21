require 'spec_helper'

describe DomainsController do

  describe "#export_zone" do
    context "with a dns_zone_id" do
      let(:dns_zone_id) { 0 }
      it 'works' do
        expect { subject.export_zone(dns_zone_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
