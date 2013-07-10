class AddResourceTypeToResourceRecords < ActiveRecord::Migration
  def change
    add_column :resource_records, :resource_type, :string
  end
end
