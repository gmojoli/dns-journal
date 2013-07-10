json.array!(@soa_sections) do |soa_section|
  json.extract! soa_section, :primary_domain_name, :zone_class, :mname, :rname, :serial_number, :refresh, :retry, :expire, :negative_caching
  json.url soa_section_url(soa_section, format: :json)
end
