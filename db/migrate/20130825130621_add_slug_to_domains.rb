class AddSlugToDomains < ActiveRecord::Migration
  def up
    add_column :domains, :slug, :string
  end
  def down
    remove_column :domains, :slug
  end
end
