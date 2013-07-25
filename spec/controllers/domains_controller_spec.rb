require 'spec_helper'

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
      before { controller.stub(:current_user).and_return user }
      it "should return a txt attachment" do
        get :export_zone, :id => domain.id, :dns_zone_id => dns_zone.id
        flash[:notice].should eql("file exported")
      end
    end
  end

end
