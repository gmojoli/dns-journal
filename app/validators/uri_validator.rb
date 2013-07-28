require 'uri'
class UriValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    r = !!URI.parse(value)
  rescue URI::InvalidURIError
    r = false
  ensure
    record.errors[attribute] << (options[:message] || "is invalid") unless r
  end
end
