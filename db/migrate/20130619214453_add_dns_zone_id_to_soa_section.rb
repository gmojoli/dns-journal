class AddDnsZoneIdToSoaSection < ActiveRecord::Migration
  def change
    add_column :soa_sections, :dns_zone_id, :integer
  end
end
