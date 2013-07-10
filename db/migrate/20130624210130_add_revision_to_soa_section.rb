class AddRevisionToSoaSection < ActiveRecord::Migration
  def change
    add_column :soa_sections, :revision, :integer
    SoaSection.all.each do |soa|
      soa.update_attributes! :revision => 1
    end
  end
end
