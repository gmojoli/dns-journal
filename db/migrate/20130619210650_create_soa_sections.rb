class CreateSoaSections < ActiveRecord::Migration
  def change
    create_table :soa_sections do |t|
      t.string :primary_domain_name
      t.string :zone_class
      t.string :mname
      t.string :rname
      t.integer :serial_number
      t.integer :refresh
      t.integer :retry
      t.integer :expire
      t.integer :negative_caching

      t.timestamps
    end
  end
end
