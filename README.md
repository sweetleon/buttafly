# Buttafly

Buttafly is a [Rails engine](http://guides.rubyonrails.org/engines.html) that, once bolted onto your rails application, allows you to manage bulk imports of real data from spreadsheets into your Rails application. 

## Por ejemplo

Let us say that your app tracks information on wineries and that: 

1. Each __winery__ *has many* __wines__ that have been produced under its imprimatur over the years.
2. Each __wine__ will axiomatically *belong to* a __winery__, and also *has many* __reviews__ written about it.
3. Each wine __review__ *belongs to* both the __wine__ it is written about, and to the __reviewer__ who wrote it. 

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

Let us also say that you have entered into an arrangement with an infamous wine critic, in which she has agreed to let you publish some of her reviews. She isn't willing to recreate the reviews in your app by hand, but she has condescended to provide you a spreadsheet which looks something like this:

| Winery name           | Wine name     | Vintage | Rating  | Review  |
| --------------        |---------------|--------:|-------- |---------| 
| Ernie & Julio Gallows | chenin blanc  | 2009    | 82      | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |
| Charles Shah          | pinot noir    | 2008    | 83      | Nearly matured and corpulent Pinot Noir. Essenses of mint, sad dog-breath, perceptable fois gras. Drink now through 2015. |
|                | semillon      | 2003    | 99      | Overdressed nevertheless complex and stunning Semillon. Shows kalamata olive, hedonistic nectarine, bashful tomato. Drink now through Friday. |

You could of course hand the spreadsheet to an intern to enter by hand, or write a script; but what if this is only the first of many wine critics who will be giving you spreadsheets? What if you have other types of objects you'd like to create? 

This is where Buttafly comes in.

Once installed, you can upload spreadsheets into your application. Buttafly knows about your app models, associations, and validations, and gives you a ui and a ui to map spreadsheet headein the exampel above allows you to create a number of mappingmap

Once uploaded Buttafly knows which models are targetable, as well as the required associations, and allows you to map the headers from the spreadsheet (or just the first row) to preOnce the spreadsheet is uploaded buttafly reads the headers from it, and asks which objects you are trying to create based on the models it recognizes in your app. In the winery example above, you would create a number of mappings:

1. A mapping for wineries using the winery name.
2. A mapping for the wine using the wine name and vintage, and the winery_id which is found by the winery name above.
3. A mapping for the review using the wine_id above as well as the user_id found by your choice of unique identifier on the user model.  

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