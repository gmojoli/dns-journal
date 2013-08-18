class ResourceRecord < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :dns_zone
  belongs_to :user

  validates :user_id, presence: true
  validates :dns_zone, presence: true
  validates_with ResourceRecordValidator

  before_save ->{ self.description = self.class.definitions[self.resource_type].join(', ') if self.description.blank? }

  class << self

    def available_resource_types
      {
        'A' => 'rfc1035',
        'CNAME' => 'rfc1035',
        'NS' => 'rfc1035',
        'MX' => 'rfc1035',
        'PTR' => 'rfc1035'
      }
    end

    def definitions
      {
        'A' => ['Address Record','Returns a 32-bit IPv4 address, most commonly used to map hostnames to an IP address of the host, but also used for DNSBLs, storing subnet masks in RFC 1101, etc.'],
        'CNAME' => ['Canonical Name Record','Alias of one name to another: the DNS lookup will continue by retrying the lookup with the new name.'],
        'NS' => ['Name Server Record','Delegates a DNS zone to use the given authoritative name servers'],
        'MX' => ['Mail Exchange Record','Maps a domain name to a list of message transfer agents for that domain'],
        'PTR' => ['Pointer Record','Pointer to a canonical name. Unlike a CNAME, DNS processing does NOT proceed, just the name is returned. The most common use is for implementing reverse DNS lookups, but other uses include such things as DNS-SD.']
      }
    end

    def tooltips
      {
        'A' => "hostname IN A IP-address",
        'CNAME' => "alias-name IN CNAME real-name",
        'NS' => "IN NS nameserver-name",
        'MX' => "IN MX preference-value email-server-name",
        'PTR' => "last-IP-digit IN PTR FQDN-of-system"
      }
    end
  end

  def rfc
    self.class.available_resource_types.fetch(resource_type){''}
  end

  def link_rfc
    URI.parse("http://tools.ietf.org/html/#{rfc}")
  end
end
