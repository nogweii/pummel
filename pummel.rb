require 'iconv'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'sinatra'
$: << File.join(File.dirname(__FILE__), 'vendor', 'ruby-oembed', 'lib')
require 'oembed'

@@rss_url = "http://feeds.pinboard.in/rss/u:evaryont/"
@@ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
def refresh_rss
    valid_string = @@ic.iconv(open(@@rss_url).read << ' ')[0..-2]
    @@rss = RSS::Parser.parse valid_string, false
end
refresh_rss()

set :public, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/templates'

# Access to the @@rss variable, used in the template
def rss
    @@rss
end

# Return a string, the proper HTML for the OEmbed response
#
# Used in the template.
def generate_html(oembed_response)
    case oembed_response.field('type')
    when 'photo'
        return "<img src='#{oembed_response.field("url")}' width='#{oembed_response.field("width")}' height='#{oembed_response.field("height")}' />"
    when 'video'
        return oembed_response.field('html')
    when 'link'
        return "<a href='#{oembed_response.url}'>#{oembed_response.field('html') || oembed_response.url}</a>"
    when 'rich'
        return oembed_response.field('html')
    else
        "<a href='#{oembed_response.url}'>#{oembed_response.field('html') || oembed_response.url}</a>"
    end
end

get '/' do
    erb :index
end

get '/refresh' do
    refresh_rss()
    redirect :/
end
