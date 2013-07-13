class AddUserIdToSoaSections < ActiveRecord::Migration
  def change
    add_column :soa_sections, :user_id, :integer
  end
end
