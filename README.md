# Buttafly

Buttafly is a ruby gem designed to help you manage bulk imports of real data into your Rails application from spreadsheets -- with the correct associations. For example, let us say you have an app that tracks information on wineries. Each winery will have many wines, and each wine will have many reviews. The review also belongs to a reviewer:

```ruby

# user.rb
has_many :reviews

# winery.rb
has_many :wines

# wine.rb
has_many :reviews
belongs_to :winery

# review.rb
belongs_to :wine
belongs_to :reviewer, class_name: "User"
``` 


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