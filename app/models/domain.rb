class Domain < ActiveRecord::Base

  belongs_to :user
  has_many :dns_zones, :dependent => :destroy

  validates :user_id, presence: true
  validates :name, :presence => true
  validates_uniqueness_of :name # :scope => :account_id
  validates_format_of :name, :with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, :message => "name must be in domain format: http(s)://www.example.com"

  def dns_zone
    DnsZone.find(current_dns_zone) if current_dns_zone
  end

  def last_dns_zone
    DnsZone.where(:domain_id => self.id).last
    # gotcha:
    # :joins set :updateonly => true !
    #DnsZone.joins(:domain).where('domains.id' => self.id).last
  end

end
