# pummel

A different view to your Pinboard bookmarks.

## Check out heroku

This is also running on Heroku. [Check it out!][heroku]

## Local installation

    $ git clone https://github.com/evaryont/pummel.git
    $ cd pummel
    $ bundle install
    $ bundle exec ruby pummel.rb

## Inspiration

I was just browsing around on the web, aimlessly when I stumbled on the [OEmbed][]
project, and subsequently found [OohEmbed][]. The author created a small-ish
javascript application called [Dumble][], which is exactly what Pummel is, but
uses a user's del.icio.us bookmarks rather than Pinboard. As I don't really use
del.icio.us but instead of pinboard.in, I decided to create my own version.

Here it is.

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a
   future version unintentionally.
4. Commit, do not mess with Rakefile, version, or history.
   (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (C) 2010/2014 Colin Shea. Released under the AGPLv3. See LICENSE for
details.

[OEmbed]: http://www.oembed.com/
[OohEmbed]: http://oohembed.com/
[Dumble]: http://oohembed.com/dumble/
[heroku]: http://pummel.heroku.com
