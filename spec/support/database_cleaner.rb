# frozen_string_literal: true

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  # config.before(:suite) do
  #   DatabaseCleaner.clean_with :truncation
  # end

  # config.before(:all) do
  #   DatabaseCleaner.clean_with :truncation
  # end

  # config.before(:each) do |spec|
  #   DatabaseCleaner.strategy = spec.metadata[:js] ? :truncation : :transaction
  #   DatabaseCleaner.start
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:all) do
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |spec|
    if spec.metadata[:js]
      spec.run
      DatabaseCleaner.clean_with :deletion, pre_count: true
    else
      DatabaseCleaner.cleaning do
        spec.run
      end

      begin
        ActiveRecord::Base.connection.send :rollback_transaction_records, true
      rescue StandardError
        nil
      end
    end
  end
end
