# Rakefile

# If there's a problem loading the tasks, we don't want Rake to crash. Most of these are non-critical after all.
begin

  # Load the default airbrake tasks
  require 'airbrake/tasks'
  require 'net/http'
  require 'net/smtp'

  Airbrake.configure do |config|
    config.api_key = YAML.load_file(File.expand_path '../../../config/airbrake.yml', __FILE__)['api_key']
    config.development_environments = []
    config.ignore_only  = []
  end

  global_error_classes = [
    # ActiveResource::TimeoutError
    # MemCache::MemCacheError,
    # Mongrel::TimeoutError,
    # ThinkingSphinx::ConnectionError,
    Net::HTTPFatalError.new('',''),
    # ActiveResource::ResourceNotFound,
    # OpenURI::HTTPError,
    # ActiveResource::ServerError,
    Net::SMTPServerBusy.new(''),
    Net::SMTPSyntaxError.new(''),
    Net::SMTPFatalError.new(''),
    # Mysql::Error
  ]

  namespace :airbrake do
    desc "Utility for airbrake test"

    task :raise_one do
      exception = global_error_classes.shuffle.first
      puts "sending #{exception.inspect}"
      Airbrake.notify_or_ignore(exception)
    end
  end

rescue Exception => e
  puts e
  $stderr.puts "Could not load Airbrake configuration!"
end
