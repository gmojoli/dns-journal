class FillSlugColumnForDomains < ActiveRecord::Migration
  def change
    Domain.find_each(&:save)
  end
end
