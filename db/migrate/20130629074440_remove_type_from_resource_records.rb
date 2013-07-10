class RemoveTypeFromResourceRecords < ActiveRecord::Migration
  def change
		remove_column :resource_records, :type
  end
end
