# Crumpet

[![Build status](https://badge.buildkite.com/314584d2128067c80fbd082008710c9f57e426c0eb7ec9333c.svg)](https://buildkite.com/blaknite/crumpet)

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

Then in the view:

```
<%= render_crumbs %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run
the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blaknite/crumpet. This
project is intended to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
