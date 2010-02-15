= pummel

Auto-tumble your RSS feed! (Default: my (Evaryont) pinboard.in links)

== Dependencies

* Rack
* Sinatra
* Ruby-OEmbed (vendored under vendor/ruby-oembed)
* RSS (built-in in Ruby 1.8+)

== Installation

    $ git clone git://github.com/evaryont/pummel.git
    $ cd pummel
    $ edit pummel.rb
    # Edit the file to point to your choice of RSS feed)
    $ rackup
    # Open your browser to http://localhost:9292/

== Demo (& Heroku)

This web application was designed for Heroku, and is immediately compatible.
You can see a demo (and my bookmarks!) at http://pummel-demo.heroku.com .

== Inspiration

I was just browsing around on the web, aimlessly when I stumbled on the [OEmbed][]
project, and subsequently found [OohEmbed][]. The author created a small-ish
javascript application called [Dumble][], which is exactly what Pummel is, but
uses a user's del.icio.us bookmarks rather than Pinboard. As I don't really use
del.icio.us but instead of pinboard.in, I decided to create my own version.

Here it is.

== Technical Overview

This is realtively geeky overview of how Pummel works, so if you want to skip it,
go right ahead.

At application initiation, an Iconv object is created, and the RSS feed is fetched
and parsed.

Every time the index page is requested, loop through each item in the feed, and
pull it's link. Check if the link is embeddable. If it is, determine the type and
use the correct HTML. (Note: This perhaps should be done by Ruby-OEmbed itself.)
If it can not be embedded, create a simple link. If there is an error when embedding,
show the error in a &lt;pre&gt; block, and create a simple link.

Every time the refresh page is requested (http://.../refresh) pull the feed again
and parse it. Then redirect the user to the index page.

== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Colin Shea. See LICENSE for details.
