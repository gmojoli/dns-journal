class CreateDomainsDnsZones < ActiveRecord::Migration
  def self.up
    create_table :domains_dns_zones do |t|
      t.integer :domain_id
      t.integer :dns_zone_id
    end
  end
  def self.down
    drop_table :domains_dns_zones
  end
end
