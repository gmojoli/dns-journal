class ChangeNegativeCachingColumnIntoMinimumInSoaSections < ActiveRecord::Migration
  def change
    rename_column :soa_sections, :negative_caching, :minimum
  end
end
