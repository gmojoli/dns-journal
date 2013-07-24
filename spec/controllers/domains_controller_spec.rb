require 'spec_helper'

FactoryGirl.define do
  factory :dns_zone do
    origin 'foo'
  end
  factory :domain do
    name 'foo'
  end
end

describe DomainsController do

  # TODO

  describe "#export_zone" do

    context "without a dns_zone_id" do
      it 'cry' do
        expect { subject.export_zone }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with a dns_zone" do
      let(:user) { create(:user)}
      let(:dns_zone) { FactoryGirl.create(:dns_zone, :origin => 'example.com', :user => user) }
      let(:domain) { FactoryGirl.create(:domain, :user => user) }
      let(:data_string)  { "some data" }
      let(:data_options) { {filename: "data.txt", disposition: 'attachment', type: 'text/plain; charset=utf-8; header=present'} }

      before { controller.stub(:authenticate_user!).and_return true }
      it "should return a txt attachment" do
        #subject.should_receive(:export_zone).and_return { true } #.with_params(...)
        get :export_zone, :id => domain.id, :dns_zone_id => dns_zone.id
        flash[:notice].should eql("its a good thing!")
      end
    end
  end

end
