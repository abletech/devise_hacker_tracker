# DeviseHackerTracker
Track failed attempts to sign in through devise.

This can allow for increased security measures, such as locking sign in after multiple failed attempts on different accounts from a single IP address.

## Requirements

- Devise: follow the setup from their page [here](https://github.com/plataformatec/devise#getting-started)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_hacker_tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise_hacker_tracker

## Usage

Generate the config additions and migrations, where `MODEL` is the name of your devise model (most likely `users`)
```bash
rails generate devise_hacker_tracker MODEL
```

This will prompt you to answer the following questions. Hit return to use the default values, or enter a different value if required.
```
What is the name of a unique identifier on your users table? (default: 'email')
What is the name the type of the users email attribute? (default: 'string')
```

The generator will create the following new files
- db/migrate/devise_create_sign_in_failures.rb
- config/locales/devise_hacker_tracker.en.yml
and also add some configuration options to `config/initializers/devise.rb`

Run `rake db:migrate` to create the new sign_in_failures database table, to store failed sign in attempts.

You can then prevent a user from signing in if they have made to many attempts at different accounts by adding the following code to your Devise sessions controller (you may need to create this controller if you haven't already. Follow the [devise explanation here](https://github.com/plataformatec/devise#configuring-controllers)). You can change the flash message and redirection path as appropriate for you application.

```
class SessionsController < Devise::SessionsController

  def create
    if HackerTracker.hacker?(request.remote_ip)
      set_flash_message :alert, :ip_blocked
      redirect_to new_user_session_path
    else
      super
    end
  end

end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AbleTech/devise_hacker_tracker.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

