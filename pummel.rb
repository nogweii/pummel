require 'iconv'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'sinatra'

@@rss_url = "http://feeds.pinboard.in/rss/u:evaryont/"
ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
valid_string = ic.iconv(open(@@rss_url).read << ' ')[0..-2]
@@rss = RSS::Parser.parse valid_string, false

def rss
    @@rss
end

get '/' do
    erb :index
end

use_in_file_templates!

__END__

@@ index
<%# Borrowed from http://rubyrss.org %>
<h4><a href="<%= rss.channel.link %>"><%= rss.channel.title %></a></h4>
% if rss.channel.date
<small>Last updated on <%= rss.channel.date.strftime("%d %b %Y") %></small>
% end
<p><%= rss.channel.description %></p>
<ol>
% rss.channel.items.each do |item|
    <li><%= item.title %></li>
%end
</ol>
