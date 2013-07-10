class AddDomainIdToDnsZones < ActiveRecord::Migration
  def change
    add_column :dns_zones, :domain_id, :integer
  end
end
