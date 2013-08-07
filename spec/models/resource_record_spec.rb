require 'spec_helper'

describe ResourceRecord do

  it "is created with minimum informations" do
    resource_record = build(:resource_record)
    expect(resource_record).to be_valid
    expect(resource_record.user).not_to be_nil
    expect(resource_record.dns_zone).not_to be_nil
  end
end
