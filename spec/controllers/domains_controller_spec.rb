require 'spec_helper'

FactoryGirl.define do
  factory :dns_zone do
    origin 'foo'
  end
end

describe DomainsController do

  # TODO


  describe "#export_zone" do
    context "with a dns_zone_id" do
      let(:dns_zone) { FactoryGirl.create(:dns_zone).tap{|x| p x} }
      it 'works' do
        expect { subject.export_zone }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    let!(:params) { {:dns_zone_id => 0} }
    let(:data_string)  { "some data" }
    let(:data_options) { {filename: "data.txt", disposition: 'attachment', type: 'text/plain; charset=utf-8; header=present'} }

    it "should return a txt attachment" do
      subject.should_receive(:export_zone).and_return { true } #.with_params(...)
      subject.export_zone
    end
  end

end
