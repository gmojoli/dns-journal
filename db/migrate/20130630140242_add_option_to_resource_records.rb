class AddOptionToResourceRecords < ActiveRecord::Migration
  def change
    add_column :resource_records, :option, :string
  end
end
