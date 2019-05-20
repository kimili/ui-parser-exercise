require 'thor'
require 'json'
require './lib/ui_parser.rb'

class InteractiveParser < Thor

  DATA_FILE = './data/SystemViewController.json'.freeze

  desc 'interface', 'open up an interactive User Interface parsing session.'
  long_desc <<-LONGDESC
    `ruby parse interface` will load the ./data/SystemViewController.json file for parsing

    You can optionally specify a path to a different JSON fine as a parameter.

    > $ ruby parse interface './data/fooInterface.json'
  LONGDESC

  def interface(file = DATA_FILE)
    data = JSON.parse File.read(file)
    parser = UIParser.new data

    say 'User Interface Data has been loaded and is ready to parse'

    loop do
      result = ask 'Enter a selector:'
      break if result =~ /^bye|exit|done|quit|end$/i
      
      pp parser.parse result
    end
  end

end