require 'spec_helper'

describe SoaSection do
  context "creation" do

    it "is created with a default revision 1" do
      soa_section = create(:soa_section)
      expect(soa_section.revision).to eq 1
    end

    it "is created with default values (" do
      soa_section = create(:soa_section)
      expect(soa_section.refresh).to eq 86000
      expect(soa_section.retry).to eq 7200
      expect(soa_section.expire).to eq 3600000
      expect(soa_section.minimum).to eq 600
    end

    it "is valid only if it has a name, a dns zone and an user" do
      soa_section = build(:soa_section)
      expect(soa_section).to be_valid
    end

  end
end
