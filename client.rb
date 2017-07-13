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
  capability = Twilio::JWT::ClientCapability.new account_sid, auth_token
  outgoingScope = Twilio::JWT::ClientCapability::OutgoingClientScope.new app_sid
  incomingScope = Twilio::JWT::ClientCapability::IncomingClientScope.new 'TwilioDevedSample'
  capability.add_scope(outgoingScope)
  capability.add_scope(incomingScope)

  @token = capability.to_s
  return @token
end
