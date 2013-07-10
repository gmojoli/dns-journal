json.array!(@dns_zones) do |dns_zone|
  json.extract! dns_zone, :admin_email, :version, :origin, :ttl, :description
  json.url dns_zone_url(dns_zone, format: :json)
end
