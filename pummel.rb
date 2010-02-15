require 'iconv'
require 'sinatra'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

@@rss_url = "http://feeds.pinboard.in/rss/u:evaryont/"
ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
valid_string = ic.iconv(open(@@rss_url).read << ' ')[0..-2]
@@rss = RSS::Parser.parse valid_string, false

get '/' do
    "#{@@rss.channel.title} <a href='#{@@rss.channel.link}'>Go</a>"
end
