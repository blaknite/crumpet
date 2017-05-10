# Crumpet

[![Build Status](https://travis-ci.org/blaknite/crumpet.svg?branch=master)](https://travis-ci.org/blaknite/crumpet)

Simple breadcrumbs for Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crumpet'
```

And then execute:

    $ bundle

## Usage

Basic usage:

```ruby
class ApplicationController
  crumbs do
    add_crumb "Home", root_path
  end
end

class WidgetsController < ApplicationController
  crumbs do
    add_crumb @widget.parent_widget.name, widget_path(@widget.parent_widget)
    add_crumb @widget.name, widget_path(@widget)
  end

  crumbs_for :edit do
    add_crumb 'Edit'
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blaknite/crumpet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
