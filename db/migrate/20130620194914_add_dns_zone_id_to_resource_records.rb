class AddDnsZoneIdToResourceRecords < ActiveRecord::Migration
  def change
    add_column :resource_records, :dns_zone_id, :integer
  end
end
