module DnsZonesHelper

  def print_errors
     @dns_zone.errors.messages
  end

end
