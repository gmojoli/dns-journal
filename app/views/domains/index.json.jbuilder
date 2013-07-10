json.array!(@domains) do |domain|
  json.extract! domain, :name
  json.url domain_url(domain, format: :json)
end
