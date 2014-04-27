require 'logger'
require 'sinatra'
require 'faraday'
require 'faraday-http-cache'
require 'slim'
require 'onebox'
require 'feedjira'

set :slim, pretty: true

# The global application log. Send to STDOUT.
system_log = Logger.new(STDOUT)
system_log.level = Logger::DEBUG

# Rack::CommonLogger uses a slightly different API for sending log messages.
# rack.errors uses puts, which is private in Logger.
Logger.class_eval { alias :write :'<<'; alias :puts :error }

configure do
  # Point CommonLogger to my Logger instance
  use Rack::CommonLogger, system_log
end

before {
  # Point Rack middleware that logs to whatever error console
  env["rack.errors"] = system_log
}

# The faraday connector
faraday = Faraday.new do |fara|
  fara.request  :url_encoded         # Make all requests URL-encoded
  fara.response :logger, system_log  # Log responses to standard out
  fara.response :raise_error         # Raise in Ruby for any 400 or 500 error
  fara.use      :http_cache, logger: system_log
  fara.adapter  Faraday.default_adapter
end
faraday.headers[:user_agent] = 'Pummel v0.4.1'

get '/' do
  slim :index
end

get '/:user' do
  @user = params[:user]
  @rss_url = "https://feeds.pinboard.in/rss/u:#@user/"
  @result = faraday.get(@rss_url)
  @rss = Feedjira::Feed.parse(@result.body.force_encoding('UTF-8'))

  if params[:details]
    slim :details
  else
    slim :user
  end
end
