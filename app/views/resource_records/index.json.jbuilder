json.array!(@resource_records) do |resource_record|
  json.extract! resource_record, :type, :value, :rfc, :description
  json.url resource_record_url(resource_record, format: :json)
end
