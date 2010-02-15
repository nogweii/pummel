require 'iconv'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'sinatra'
$: << File.join(File.dirname(__FILE__), 'vendor', 'ruby-oembed', 'lib')
require 'oembed'

@@rss_url = "http://feeds.pinboard.in/rss/u:evaryont/"
ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
valid_string = ic.iconv(open(@@rss_url).read << ' ')[0..-2]
@@rss = RSS::Parser.parse valid_string, false

set :public, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/templates'

def rss
    @@rss
end

get '/' do
    erb :index
end
