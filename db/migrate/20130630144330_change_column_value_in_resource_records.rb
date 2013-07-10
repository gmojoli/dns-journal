class ChangeColumnValueInResourceRecords < ActiveRecord::Migration
  def change
    change_column :resource_records, :value, :string
  end
end
