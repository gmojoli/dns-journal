require 'spec_helper'

describe SoaSectionsController, :type => [:controller] do

  context "creating a soa_section" do

    before(:each) do
      @dns_zone = create(:dns_zone, :user => @user)
      SoaSection.find(@dns_zone.soa_section).destroy
    end

    context "with valid attributes" do
      it "creates a new soa section" do
        expect {
          post :create, :domain_id => @dns_zone.domain.slug, :dns_zone_id => @dns_zone.id, soa_section: FactoryGirl.attributes_for(:soa_section)
        }.to change(SoaSection, :count).by(1)
      end

      it "redirects to the dns_zone view" do
        post :create, :domain_id => @dns_zone.domain.slug, :dns_zone_id => @dns_zone.id, soa_section: FactoryGirl.attributes_for(:soa_section)
        response.should redirect_to(redirect_to domain_dns_zone_path(@dns_zone.domain, @dns_zone))
        flash[:notice].should eql("Soa section was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not save the new soa section" do
        expect{
          post :create, :domain_id => @dns_zone.domain.slug, :dns_zone_id => @dns_zone.id, soa_section: FactoryGirl.attributes_for(:invalid_soa_section)
        }.to_not change(SoaSection,:count)
      end

      it "re-renders the edit method" do
        post :create, :domain_id => @dns_zone.domain.slug, :dns_zone_id => @dns_zone.id, soa_section: FactoryGirl.attributes_for(:invalid_soa_section)
        response.should render_template('edit')
        flash[:alert].should match("failed")
      end
    end
  end

  context "updating a soa_section" do

    before(:each) do
      @dns_zone = create(:dns_zone, :user => @user)
      @soa_section = @dns_zone.soa_section
    end

    it "increment also the revision value and the serial_number" do
      old_serial_number = @soa_section.serial_number
      put :update, {:domain_id => @soa_section.dns_zone.domain.slug, :dns_zone_id => @soa_section.dns_zone.id, :id => @soa_section.id,  :soa_section => {primary_domain_name: 'updated.foo.com'} }
      @soa_section.reload
      expect(@soa_section.revision).to eq 2
      expect(@soa_section.serial_number).to eq(old_serial_number + 1)
    end

  end
end
