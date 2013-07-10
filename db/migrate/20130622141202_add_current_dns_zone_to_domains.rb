class AddCurrentDnsZoneToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :current_dns_zone, :integer
  end
end
