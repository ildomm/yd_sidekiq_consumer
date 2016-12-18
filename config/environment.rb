# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ENV['SSL_CERT_FILE'] = 'C:/Dev/Install/gems/cacert.pem'