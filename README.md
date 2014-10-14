# OkFilter

v0.2.0

I've had a lot of luck on OkCupid, but I find that it requires a lot of repetitive work to really get good results out of it. I've found that their rating system works pretty well to filter people: 1 starred people aren't shown to you (or you to them) and mutual 4/5 stars are notified of the match.

When you hide or 1 star enough people, OkCupid will 'refresh' who it shows you, which means you'll get a new batch of people to look at. From these, you can see pretty quick that the best way to use the site is to 1star the people you're not interested in as quickly as possible.

Fortunately, OKC's match algorithm actually works really well. If your questions/answers are well calibrated, anyway.

This script asks for your login information, logs in to OkCupid, and starts rating people based on match percentage. Currently, it 1 stars anyone less than 60% and 5 stars anyone higher than 90% by default, skipping everyone in between. It will run until terminated (or it crashes).

## To Use:

`ruby OkFilter.rb [-v] [-h] [-u Username] [-L 90] [-F 60]`

`-v` will cause OkFilter to log output to the console.

`-h` will print help information.

`-u Username` will preset your username.

`-L 90` allows you to set the number at which OkFilter will 'Like' someone. 90% match is the default. 100 won't 'Like' anyone.

`-F 60` allows you to set the number at which OkFilter will 'Dislike' someone. 60% match is the default. 0 won't 'Dislike` anyone.

## To Install:

### Windows

1. Install [Ruby 1.9.3](http://rubyinstaller.org/downloads/)
2. Download/clone the repository (link to the right)
3. Extract the repository to a folder
4. Go into the 'OkFilter-master' folder, hold Shift and right-click in the folder area. Choose 'Open command window here'
5. Type `gem install bundler` and press enter. This installs the dependency installer.
6. Once that has completed, type `bundler install` and press enter. This installs the dependencies required to run the program.
7. To run the program, type `ruby OkFilter.rb` in the direcotry. Extra usage information is available above.
