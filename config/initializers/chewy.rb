Chewy.settings = { prefix: 'top' }
Chewy.request_strategy = :sidekiq if ENV['TOP_ENV'] == 'production'
