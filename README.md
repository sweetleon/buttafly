# Buttafly

Buttafly is a ruby gem designed to help you manage bulk imports of real data into your Rails application with the desired associations. For example, let us say that your app tracks information on wineries -- indeed, the author's work on bacchan.al and bloocher.com is what inspired it. Each winery will have many wines, each wine will belong to a winery and have many reviews, and each wine review will belong to both a wine and to a reviewer. Your models might look like this:

# app/models/winery.rb
```ruby
has_many :wines

# app/models/wine.rb
```ruby
has_many :reviews
belongs_to :winery
```
# app/models/review.rb
```ruby
belongs_to :wine
belongs_to :reviewer, class_name: "User"
```
# app/models/user.rb
```ruby
has_many :reviews
```

Let us also say that you have entered into an arrangement with a famous wine critic such as [Ken Zinns](http://www.grape-nutz.com/kenz/) in which he has agreed to let you publish a portion of his reviews. Unfortunately he is a busy man, and is unlikely to use the user interface you've created, no matter how beautiful you've tried to make it, to manually search for each wine, create a wine if it doesn't exist, and perhaps even create the winery as well, before cutting and pasting his review. But he might be willing to give you a spreadsheet, the rows of which might look like so:

winery 

Colons can be used to align columns.

| Winery name   | Wine name     | Vintage | Are           | Cool  |
| ------------- |---------------| -----:|
| col 3 is      | right-aligned |  2009 |
| col 2 is      | centered      |    |
| zebra stripes | are neat      |     1 |

The outer pipes (|) are optional, and you don't need to make the raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3




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