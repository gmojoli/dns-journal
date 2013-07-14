class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :domains
  has_many :dns_zones
  has_many :soa_sections
  has_many :resource_records

  has_and_belongs_to_many :roles
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  def admin?
  	roles.map(&:name).include? 'admin'
  end
end