require 'sinatra'
require 'twilio-ruby'

before do
  validate_twilio_request()
end

# Voice Request URL - receives incoming calls from Twilio
post '/voice/?' do
  # Customize the message to the caller's phone number
  from_number = params[:From]

  # create a new TwiML response
  response = Twilio::TwiML::Response.new do |r|
    # <Say> a message to the caller
    r.Say "Thanks for calling! Your phone number is #{from_number}. I got your call because of Twilio's webhook. Goodbye!", :voice => 'alice', :language => 'en-gb'
  end
  response.text
end

# SMS Request URL - receives incoming messages from Twilio
post '/message/?' do
  # Customize the message with length of the incoming message
  msg_length = params[:Body].length

  # <Message> a text bac to the person who texted us
  response = Twilio::TwiML::Response.new do |r|
    r.Sms  "Your text to me was #{msg_length} characters long. Webhooks are neat :)"
  end

  # Return the TwiML
  response.text
end

# Authenticate that all requests to our public-facing TwiML pages are
# coming from Twilio.
private
def validate_twilio_request
  twilio_signature = request.env['HTTP_X_TWILIO_SIGNATURE'] || 'invalid'

  # Helper from twilio-ruby to validate requests.
  @validator = Twilio::Util::RequestValidator.new ENV['TWILIO_AUTH_TOKEN'] 

  # the POST variables attached to the request (eg "From", "To")
  # Twilio requests only accept lowercase letters. So scrub here:
  post_vars = params

  is_twilio_req = @validator.validate request.url, post_vars, twilio_signature

  unless is_twilio_req
    content_type 'text/xml'
    response = (Twilio::TwiML::Response.new {|r| r.Hangup}).text
    halt 401
  end
end