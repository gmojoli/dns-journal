class SetDefaultRole < ActiveRecord::Migration
  def change
  	user_role = Role.where(:name => 'user').first_or_create
  	User.all.each do |user|
  		user.roles << user_role
  	end
  end
end
