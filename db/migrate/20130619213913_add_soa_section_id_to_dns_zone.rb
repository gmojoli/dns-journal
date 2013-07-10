class AddSoaSectionIdToDnsZone < ActiveRecord::Migration
  def change
    add_column :dns_zones, :soa_section_id, :integer
  end
end
