# Webhooks Example (Sinatra)

This tiny repo shows you how to use Twilio webhooks with Sinatra.

## Configure Development vs Production Settings

By default, this application will run in production mode - stack traces will not be visible in the web browser. If you would like to run this application in development locally, change the `APP_ENV` variable in your `.env` file.

`APP_ENV=development`

For more about development vs production, visit [Sinatra's configuration page](http://sinatrarb.com/configuration.html).
