# OkFilter

v0.1.0

I've had a lot of luck on OkCupid, but I find that it requires a lot of repetitive work to really get good results out of it. I've found that their rating system works pretty well to filter people: 1 starred people aren't shown to you (or you to them) and mutual 4/5 stars are notified of the match.

When you hide or 1 star enough people, OkCupid will 'refresh' who it shows you, which means you'll get a new batch of people to look at. From these, you can see pretty quick that the best way to use the site is to 1star the people you're not interested in as quickly as possible.

Fortunately, OKC's match algorithm actually works really well. If your questions/answers are well calibrated, anyway.

This script asks for your login information, logs in to OkCupid, and starts rating people based on match percentage. Currently, it 1 stars anyone less than 70% and 5 stars anyone higher than 90%, skipping everyone in between.It will run until terminated.
