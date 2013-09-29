# https://github.com/airbrake/airbrake
Airbrake.configure do |config|

  # Load the API key from a file in the repo
  api_key = YAML.load_file(File.expand_path '../../airbrake.yml', __FILE__)['api_key']
  # Load the API key from the environment
  # api_key = ENV['AIRBRAKE_API_KEY'] or raise "No API key in ENV"
  puts "Initializing airbrake: api-key: #{api_key}"

  # Collect Errors from your Development Environment
  config.development_environments = []

  #Send Every Error (and override the defaults)
  config.ignore_only  = []

  # config.logger = Logger.new("path/to/your/log/file")
end
