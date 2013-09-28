# https://github.com/airbrake/airbrake
Airbrake.configure do |config|
  config.api_key = 'cc6d61734ab784f6fa615f0b64dc123b'
  # Collect Errors from your Development Environment
  config.development_environments = []

  #Send Every Error (and override the defaults)
  config.ignore_only  = []

  # config.logger = Logger.new("path/to/your/log/file")
end
