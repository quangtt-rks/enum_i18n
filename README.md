[![Gem Version](https://badge.fury.io/rb/enum_i18n.svg)](https://rubygems.org/gems/enum_i18n) [![Mood](https://img.shields.io/badge/mood-bored-blue.svg)](https://quangteomedia.com)

# EnumI18n

This gem helps ActiveRecord::Enum work smoothly with Internationalization.

From Rails 4.1.0, ActiveRecord supported Enum method. But if you want do deal with I18n, you do it by yourself, many of redundant code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enum_i18n'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum_i18n

## Usage

Required Rails 4.1.x

In model file:

```ruby
class Person < ActiveRecord::Base
  enum character: { nice: 0, bad: 1 }
end
```

In locale file:

```yaml
# config/locales/models/person/ja.yml
ja:
  activerecord:
    models:
      person: 人
    attributes:
      person:
        name: 名前
        character: キャラクター
        characters:
          nice: 良い
          bad: 悪い
```

Using:

```ruby
person = Person.first
person.character
# > "nice"
person.character_i18n
# > "良い"

Person.characters_i18n
# > {"nice"=>"良い", "bad"=>"悪い"}
```

```ruby
# Using within a form
<%= f.select :character, options_for_select(Person.characters_options_i18n) %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quangtt/enum_i18n. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( http://github.com/quangtt/enum_i18n/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
