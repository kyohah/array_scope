# ArrayScope

そのクラスの配列にメソッドを定義する
配列に入っているクラス名を確認し、メソッド名衝突を防いでいる

[JP](https://qiita.com/kyohah/private/9fb8f969fbb74926e8bd) / [EN](https://dev.to/sonodasnd/i-created-a-gem-that-allows-you-to-write-a-method-to-an-array-in-activemodel-42na-temp-slug-91007?preview=66abbaa22e8cacd906230fa500090b790d5b41c955d1c411c67b8b3d1fbee3ab03b05050a98c1eb7c1dd95410e7ad77875e5a72cce07632960508e43)

## Usage

```
class Hoge
  extend ArrayScope

  array_scope :moge, -> { 'from Hoge' }
end

class Boke
  extend ArrayScope

  array_scope :moge, -> { 'from Boke' }
end

[Hoge.new].moge # => "from Hoge"
[Boke.new].moge # => "from Boke"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'array_scope'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install array_scope


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/array_scope. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/array_scope/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ArrayScope project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/array_scope/blob/master/CODE_OF_CONDUCT.md).
