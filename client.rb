require 'sinatra'
require 'twilio-ruby'

# Twilio Client URL
post '/client/?' do
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  app_sid = ENV['TWILIO_APP_SID']
  
  if !(account_sid && auth_token && app_sid)
    return "Please run configure.rb before trying to do this!"
  end
  capability = Twilio::Util::Capability.new account_sid, auth_token
  capability.allow_client_outgoing(app_sid)
  capability.allow_client_incoming('TwilioDevedSample')
  @token = capability.generate
  return @token
end