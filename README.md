# Buttafly

Buttafly is a ruby gem designed to help you manage bulk imports of real data into your Rails application with the desired associations. For example, let us say that your app tracks information on wineries -- indeed, the author's work on bacchan.al and bloocher.com is what inspired it. Each winery will have many wines, each wine will belong to a winery and have many reviews, and each wine review will belong to both a wine and to a reviewer. Your models might look like this:

```ruby
# app/models/winery.rb
has_many :wines
```

```ruby
# app/models/wine.rb
has_many :reviews
belongs_to :winery
```

```ruby
# app/models/review.rb
belongs_to :wine
belongs_to :reviewer, class_name: "User"
```

```ruby
# app/models/user.rb
has_many :reviews
```

Let us also say that you have entered into an arrangement with a famous wine critic such as [Ken Zinns](http://www.grape-nutz.com/kenz/), in which he has agreed to let you publish a portion of his reviews. Unfortunately, wine critics are often busy men, and thus unlikely to use the user interface you've created, no matter how beautiful, in order to recreate each review -- to first find or create the winery in the system, then find or create the wine under that winery's list of wines, and then copy and paste in his review. But fortunately, Ken is willing to provide you his reviews in a .csv file that looks something like this:

| Winery name   | Wine name     | Vintage | Rating | Review  |
| ------------- |---------------|--------:|--------|---------| 
| Ernest & Julio Gallo | Table Wine |  2009 | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |


The alternative is that you can hire someone to put them into your app for you, or you can write a script


, in order to manually search for each winery, or create it if it doesn't exist, and then create a wine if it doesn't exist, and perhaps even create the winery as well, before cutting and pasting his review. But he might be willing to give you a spreadsheet, the rows of which might look like so:

winery 


 Let's say you

let's say you have a .csv file with wine reviews, and you if you have a wine application where each review belongs to a wine and a user, and each wine belongs to a winery, it allows you to find or create the user and build a review object with the user's user_id and a wine_id. If 

a [Rails engine](http://guides.rubyonrails.org/engines.html) 
## Getting Started

Add buttafly to your Gemfile with the following line:

```ruby
gem 'buttafly'
```

Then from the command line:

```console
bundle install
```



## License

[MIT-LICENSE](http://en.wikipedia.org/wiki/MIT_License)