class AddUserIdToDnsZones < ActiveRecord::Migration
  def change
    add_column :dns_zones, :user_id, :integer
  end
end
