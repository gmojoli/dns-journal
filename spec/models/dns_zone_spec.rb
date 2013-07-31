require 'spec_helper'

describe DnsZone do
  it "is created with default version and TTL 0" do
    dnzone = create(:dns_zone)
    dnzone.should be_valid
    dnzone.version.should be 1
  end

  it "give the last version for his origin" do
    10.times{ |n| create(:dns_zone, :origin => 'foo.com', version: n) }

    DnsZone.last[:version].should eq 9
    DnsZone.last.new_version.should eq 10
  end
  it "must be unique for an user"
  it "can clone itself"
end