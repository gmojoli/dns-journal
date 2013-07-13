class AddIndicesToUsers < ActiveRecord::Migration
  def change
  	add_index :dns_zones, :user_id
  	add_index :domains, :user_id
  	add_index :resource_records, :user_id
  	add_index :soa_sections, :user_id
  end
end
