class CreateDnsZones < ActiveRecord::Migration
  def change
    create_table :dns_zones do |t|
      t.string :admin_email
      t.integer :version
      t.string :origin
      t.integer :ttl
      t.text :description

      t.timestamps
    end
  end
end
