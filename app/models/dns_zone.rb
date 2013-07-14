class DnsZone < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :domain
  belongs_to :user
  has_one :soa_section, :dependent => :destroy
  has_many :resource_records, :dependent => :destroy
  
  validates :user_id, presence: true

  validates :origin, :presence => true

  # validates :origin, :uniqueness => { :scope => :version }
  # validates_uniqueness_of :origin, :scope => :version, :case_sensitive => false?
  # validates :origin, :uniqueness => true, :unless => :already_existing?
  validates :origin, :uniqueness => { :if => :first?, :scope => :user }

  validates :ttl, :numericality => { :only_integer => true }, :allow_nil => true
  validates :admin_email, :email => true, :allow_nil => true#, :message => "invalid email"
  validates_format_of :origin, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(\/.*)?\z/ix, :message => "name must include the Top-Level domain name: example.com"

  scope :max_version, -> { DnsZone.where(:origin => origin).order("version DESC").first }  
  scope :last, -> { DnsZone.where(:origin => origin).order( "updated_at DESC" ).first }
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
end
