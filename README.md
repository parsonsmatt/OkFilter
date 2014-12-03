# OkFilter

v0.3.2

I've had a lot of luck on OkCupid, but I find that it requires a lot of repetitive work to really get good results out of it. I've found that their rating system works pretty well to filter people: 1 starred people aren't shown to you (or you to them) and mutual 4/5 stars are notified of the match.

When you hide or 1 star enough people, OkCupid will 'refresh' who it shows you, which means you'll get a new batch of people to look at. From these, you can see pretty quick that the best way to use the site is to 1star the people you're not interested in as quickly as possible.

Fortunately, OKC's match algorithm actually works really well. If your questions/answers are well calibrated, anyway.

This script asks for your login information, logs in to OkCupid, and starts rating people based on match percentage. Currently, it 1 stars anyone less than 60% and 5 stars anyone higher than 90% by default, skipping everyone in between. It will run until terminated (or it crashes).

I've updated the application to have a GUI with [Shoes](http://www.github.com/shoes/shoes4). The command-line script still works if you'd prefer to use that.

OkCupid's new quick match page doesn't allow for skipping of profiles. This will quickly build up a queue of people in between your "Like" and "Dislike" percentages, which you'll need to sort through manually.

## To Use (GUI):

`shoes OkShoes.rb`

The GUI requires jruby-1.7.16 and the Shoes4444 gem. 

## To Use (CLI):

`ruby OkFilter.rb [-v] [-h] [-u Username] [-L 90] [-F 60]`

`-v` will cause OkFilter to log output to the console.

`-h` will print help information.

`-u Username` will preset your username.

`-L 90` allows you to set the number at which OkFilter will 'Like' someone. 90% match is the default. 100 won't 'Like' anyone.

`-F 60` allows you to set the number at which OkFilter will 'Dislike' someone. 60% match is the default. 0 won't 'Dislike` anyone.

## Change log:

- v0.3.2: Fixes and slight performance enhancements.
- v0.3.1: OkCupid updated their QuickMatch to just 'Like' and 'Dislike'. I've updated the app to work with the new layout.
