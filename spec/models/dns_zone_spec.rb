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

  it "must be unique for an user" do
    dns_zone_foo = create(:dns_zone)
    dns_zone_bar = create(:dns_zone)
    another_dns_zone = FactoryGirl.build(:dns_zone, :user => dns_zone_foo.user, :domain => dns_zone_foo.domain)
    another_dns_zone.should_not be_valid
  end

  it "can clone itself" do
    dns_zone_foo = create(:dns_zone)
    dns_zone_clone = dns_zone_foo.deep_clone
    expect(dns_zone_clone.domain).to eq dns_zone_foo.domain
    expect(dns_zone_clone.soa_section.primary_domain_name).to eq dns_zone_foo.soa_section.primary_domain_name
    expect(dns_zone_clone.resource_records).to eq dns_zone_foo.resource_records
  end
end
