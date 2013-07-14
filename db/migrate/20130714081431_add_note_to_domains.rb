class AddNoteToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :note, :text
  end
end
