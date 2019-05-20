# UI Parser Exercise

This is a short exercise in building a command line tool. It loads in [JSON data](https://github.com/kimili/ui-parser-exercise/blob/master/data/SystemViewController.json) which describes a user interface and sets up an interactive command prompt which allow you to query the data with selectors. The tool will look for matches in the JSON based on the selector you input and print out an array of matching nodes from the data.

Built in Ruby, this makes use of the [Thor](https://github.com/erikhuda/thor) gem for simplifying the low level needs of building out command line tools. It also makes use of [RSpec](https://rspec.info) for tests.

## Getting Started

You'll most likely need to run `bundle` to ensure that you have the dependencies installed. From the project root:

```
$ bundle
```

Once you do that, you can run the tool with the following command:

```
$ ruby parse interface
```

That will open up an interactive sesssion and prompt you for a selector. Valid Selector types include:

- **class** - The view class name, e.g. `StackView`
- **classNames** - CSS class names, e.g. `.container`
- **identifier** - The view identifier, e.g. `#videoMode`

You can end the interactive session by typing `bye`, `quit`, `exit`, `end`, or `done`.

## Testing

You can run the tests by issuing the following command, again from the project root directory:

```
bundle exec rspec --format documentation
```

If you don't want verbose output, you can just omit the `--format documentation` flag in the above command.
