class CreateResourceRecords < ActiveRecord::Migration
  def change
    create_table :resource_records do |t|
      t.string :type
      t.integer :value
      t.string :rfc
      t.text :description

      t.timestamps
    end
  end
end
