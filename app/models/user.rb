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

  before_create :set_default_role

  def admin?
    roles.map(&:name).include? 'admin'
  end

  private
  def set_default_role
    self.roles << Role.find_by_name('user')
  end

end
