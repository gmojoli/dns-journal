class DnsZone < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :domain
  belongs_to :user
  has_one :soa_section, :dependent => :destroy
  has_many :resource_records, :dependent => :destroy

  validates :user_id, :presence => { :message => "user owner is required" }

  validates :origin, :presence => { :message => "origin is required" }

  # validates :origin, :uniqueness => { :scope => :version }
  # validates_uniqueness_of :origin, :scope => :version, :case_sensitive => false?
  # validates :origin, :uniqueness => true, :unless => :already_existing?
  validates :origin, :uniqueness => { :if => :first?, :scope => :user, :message => 'origin must be unique for the user'}

  validates :ttl, :numericality => { :only_integer => true }, :allow_nil => true
  validates :admin_email, :email => {:message => "invalid email"}, :allow_nil => true
  validates_format_of :origin, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(\/.*)?\z/ix, :message => "name must include the Top-Level domain name: example.com"

  scope :max_version, -> { DnsZone.where(:origin => self[:origin]).order("version DESC").first }
  scope :last_by_origin, -> { DnsZone.where(:origin => self[:origin]).order( "updated_at DESC" ).first }
  scope :owned_by, ->(user_id) { where(user_id: user_id) }

  after_initialize :init

  def init
    self.version  ||= 1
    self.ttl ||= 0
  end

  def new_version
     DnsZone.where(:origin => origin).order( "version DESC" ).first.version + 1
  end

  def already_existing?
    DnsZone.where(:origin => origin).where(:version => version).empty?
  end

  def first?
    version == 1
  end

  def deep_clone
    new_dns_zone = self.dup
    new_dns_zone.soa_section = self.soa_section.dup if self.soa_section
    Array(self.resource_records).each do |rr|
      new_dns_zone.resource_records << rr.dup
      puts rr.inspect
    end
    new_dns_zone
  end

end
