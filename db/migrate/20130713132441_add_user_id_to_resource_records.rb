class AddUserIdToResourceRecords < ActiveRecord::Migration
  def change
    add_column :resource_records, :user_id, :integer
  end
end
