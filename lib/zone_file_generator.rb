require 'tempfile'

class ZoneFileGenerator < ActionController::Base
  @queue = :zone_file_queue

  class << self

    def generate_file_content(dns_zone, version)
      file_content = "#{header(version)}\n"
      file_content.concat "$ORIGIN #{dns_zone.origin}.\n$TTL #{dns_zone.ttl}\n"
      file_content.concat "; -- soa section\n"
      if dns_zone.soa_section
        file_content.concat "#{dns_zone.origin}. #{dns_zone.soa_section.zone_class} SOA #{dns_zone.soa_section.primary_domain_name} #{dns_zone.admin_email}. "
        file_content.concat "(\n\t#{dns_zone.soa_section.serial_number} ; serial\n\t#{dns_zone.soa_section.refresh} ; refresh after #{dns_zone.soa_section.refresh} seconds\n\t#{dns_zone.soa_section.retry} ; retry after #{dns_zone.soa_section.retry} seconds\n\t#{dns_zone.soa_section.expire} ; expire after #{dns_zone.soa_section.expire} seconds\n\t#{dns_zone.soa_section.minimum} ; minimum\n)\n"
      end
      file_content.concat "; -- resource records\n"
      Array(dns_zone.resource_records).each do |rr|
        file_content.concat "; #{ResourceRecord.definitions.fetch(rr.resource_type)[0]}\n"
        file_content.concat "#{rr.to_code_string}\n"
      end
    end

    def perform(dns_zone_id, version)
      dns_zone = DnsZone.find(dns_zone_id)
      if dns_zone
        file_content = self.generate_file_content(dns_zone, version)
        file = "#{dns_zone.domain.name}.txt"
        Tempfile.open(file, Rails.root.join('tmp') ) do |f|
          f.print file_content
          f.flush
        end
        send_file( file )
        # send_data( file_content, :filename => "#{@domain.name}.txt" )
      end
    end

    private

      def header(version)
        "; -- zonefile created with Dns-Journal (#{version}) - #{Date.today}"
      end

  end

end
