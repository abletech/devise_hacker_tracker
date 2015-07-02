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

    $ bundle install

## Usage

To setup the gem and generate the relevant config additions and migrations, run:
```bash
$ rails generate devise_hacker_tracker sign_in_failures
```
- To change the name of the database table storing the failed sign in attempts, replace `sign_in_failures` with your preferred name
- To use uuid as the index for the `sign_in_failures` table, add the flag `--enable-uuid`


The generator will create the following new files
- db/migrate/devise_create_sign_in_failures.rb
- config/locales/devise_hacker_tracker.en.yml

and also add some configuration options to config/initializers/devise.rb.

Create the new `sign_in_failures` database table by running:
```bash
$ rake db:migrate
```

You can then prevent a user from signing in, if they have made too many attempts at different accounts, by adding the following code to your Devise sessions controller (you may need to create this controller if you haven't already. Follow the [devise explanation here](https://github.com/plataformatec/devise#configuring-controllers)). You can change the flash message and redirection path as appropriate for your application.

```ruby
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AbleTech/devise_hacker_tracker.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

