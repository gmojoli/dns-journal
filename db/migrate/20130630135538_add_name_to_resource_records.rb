class AddNameToResourceRecords < ActiveRecord::Migration
  def change
    add_column :resource_records, :name, :string
  end
end
