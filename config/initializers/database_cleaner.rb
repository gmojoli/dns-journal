unless Rails.env.production?
  require 'database_cleaner'

  DatabaseCleaner.strategy = :transaction

  # then, whenever you need to clean the DB
  # DatabaseCleaner.clean
end
