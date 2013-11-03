require 'fqdn_validator'

class ResourceRecordValidator < ActiveModel::Validator

  def validate(record)
    if record.dns_zone
      case record.resource_type
      when 'A'
        # hostname IN A IP-address
        record.errors[:name] << "an A record must define an hostname as name" unless !!URI.parse(record.name) || !record.name.present?
        record.errors[:value] << "an A record must have an IP address as value" unless record.value =~ /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/
      when 'CNAME'
        # alias-name IN CNAME real-name
        record.errors[:value] << "CNAME records must always be pointed to another domain name, never to an IP-address." if record.value =~ /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/
        record.errors[:value] << "CNAME records must always be pointed to another domain name, never to an IP-address." unless FqdnValidator.validate_fqdn(record.value)
        record.errors[:value] << "CNAME records should not contain other resource record types (such as A, NS, MX, etc.)" unless record.dns_zone.resource_records.select{ |rr| rr.value == record.value && (record.id && rr.id != record.id) }.empty?
      when 'NS'
        # IN NS nameserver-name
        record.errors[:value] << "MX and NS records must never point to a CNAME alias (RFC 2181 section 10.3)." unless record.dns_zone.resource_records.select{ |rr| rr.resource_type == 'CNAME' && rr.value == record.value }.empty?
        record.errors[:value] << "The nameserver-name should be a fully qualified domain name (FQDN)." unless FqdnValidator.validate_fqdn(record.value)
      when 'MX'
        # IN MX preference-value email-server-name
        begin
          URI.parse(record.value)
        rescue URI::InvalidURIError
          record.errors[:value] << "MX must define an hostname in his value (mx.hostname.com)"
        end
        record.errors[:value] << "MX must be a valid FQDN (mx.hostname.com)" unless FqdnValidator.validate_fqdn(record.value)
        record.errors[:value] << "MX and NS records must never point to a CNAME alias (RFC 2181 section 10.3)." unless record.dns_zone.resource_records.select{ |rr| rr.resource_type == 'CNAME' && rr.value == record.value}.empty?
        record.errors[:option] << "Mail Exchanger must define a priority value (option field)." unless record.option.present?
      when 'PTR'
        # last-IP-digit IN PTR FQDN-of-system
        record.errors[:name] << "an PTR name must be a number {3}" unless record.name =~ /^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/ # 0 or 000..255
        record.errors[:value] << "PTR must be a valid FQDN (hostname.com)" unless FqdnValidator.validate_fqdn(record.value)
      else
        record.errors[:resource_type] << "Resource Record Type is mandatory."
      end
    end
  end
end
