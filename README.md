# Pseudocode.js for Ruby

This rubygem enables you to render LaTeX pseudocode algorithms to HTML using [pseudocode.js] and [KaTeX].

This code is heavily inspired by [KaTeX for Ruby](https://github.com/glebm/katex-ruby) and it uses it and [ExecJS] under the hood.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pseudocode', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pseudocode

## Usage

Render some algorithm:

```ruby
Pseudocode.render algorithm
#=> "<span class=\"root\">..."
```

Learn more about all the available synyax in the [documentation](https://github.com/SaswatPadhi/pseudocode.js#grammar=).

### Assets

For this rendered algorithms to look nice, you will also need to include Pseudocode CSS
into the webpage.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

[KaTeX]: https://github.com/Khan/KaTeX
[ExecJS]: https://github.com/rails/execjs
[pseudocode.js]: https://github.com/SaswatPadhi/pseudocode.js
