     _           _   _         __ _       
    | |__  _   _| |_| |_ __ _ / _| |_   _ 
    | '_ \| | | | __| __/ _` | |_| | | | |
    | |_) | |_| | |_| || (_| |  _| | |_| |
    |_.__/ \__,_|\__|\__\__,_|_| |_|\__, |
                                    |___/ 


# Buttafly

Buttafly is a [Rails engine](http://guides.rubyonrails.org/engines.html). Once bolted onto your rails application, it allows you to manage bulk imports of real data from spreadsheets into your Rails application, complete with the correct associations. 

## Example

Let us say that your app tracks information on wineries and that: 

1. Each __winery__ *has many* __wines__ that have been produced under its imprimatur in a number of different vintages.
2. Each __wine__ axiomatically *belongs to* a __winery__, and also *has many* __reviews__ written about it.
3. Each wine __review__ *belongs to* both the __wine__ of which it is a subject, and to the __reviewer__ who wrote it. 

Your model associatons might look like this:

```ruby
# in app/models/winery.rb

has_many :wines
```
```ruby
# in app/models/wine.rb

has_many :reviews
belongs_to :winery

validates :winery, presence: true
```
```ruby
# in app/models/review.rb

belongs_to :wine
belongs_to :reviewer, class_name: "User"

validates :reviewer, :wine, presence: true
```
```ruby
# in app/models/user.rb

has_many :reviews, foreign_key: :reviewer_id
```

Let us also say that you have entered into an arrangement with an infamous wine critic, in which she has agreed to let you publish some of her reviews. She isn't willing to recreate the reviews in your app by hand, but she has condescended to provide you a spreadsheet which might look something like this:

| Winery name           | Wine name     | Vintage | Rating  | Review  |
| --------------        |---------------|--------:|-------- |---------| 
| Ernie & Julio Gallows | chenin blanc  | 2009    | 82      | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |
| Charles Shah          | pinot noir    | 2008    | 83      | Nearly matured and corpulent Pinot Noir. Essenses of mint, sad dog-breath, perceptable fois gras. Drink now through 2015. |
| Duckhorndog           | semillon      | 2003    | 99      | Overdressed nevertheless complex and stunning Semillon. Shows kalamata olive, hedonistic nectarine, bashful tomato. Drink now through Friday. |

You could of course hand the above spreadsheet to an intern, and ask them to navigate your applicaton to create the reviews, wineries, and wineries all by hand. Alternatively you might commission a highly paid Ruby on Rails developer to write a script to do the same thing. But what if this spreadsheet is only the first of many, from different wine critics, each of which will have slightly different headers and columns? 

This is where Buttafly comes in.

Once installed, you can upload a spreadsheet such as the above into a spreadsheet table, which buttafly can then parse. Buttafly knows about your application's models, associations, and validations, and gives you an interface for mapping your spreadsheet columns to attributes in your application's models. For the spreadsheet example above, you would first create a mapping for wineries, then one for wines that belong to those wineries, then users, and then a final mapping for the review which can then be properly associated as belonging to both the user who wrote it and to the wine which is its subject. Once the mappings are created, you can then import the spreadsheet and it will use the mappings to create the correct associated winery, wine, user and review objects. 


## Getting Started

Add buttafly to your Gemfile with the following line:

```ruby
gem 'buttafly'
```

Then from the command line:

```console
bundle install
rake db:migrate
```
Try it in development first by navigating to [localhost:3000/buttafly](localhost:3000/buttafly).

## Contributing

After cloning the application, bundling its gems, and migrating the database, you can run your tests with guard from the root of the engine itself:

```console
cd /buttafly
bundle exec guard
```
To see buttafly running from a dummy app, 

```console
cd /buttafly/test/dummy
bundle exec rails s
```
## License

[MIT-LICENSE](http://en.wikip edia.org/wiki/MIT_License)