require 'thor'
require 'json'

class UIParser < Thor

  DATA_FILE = './data/SystemViewController.json'.freeze

  desc 'interface', 'open up an interactive User Interface parsing session.'
  long_desc <<-LONGDESC
    `ruby parse interface` will load the ./data/SystemViewController.json file for parsing

    You can optionally specify a path to a different JSON fine as a parameter.

    > $ ruby parse interface './data/fooInterface.json'
  LONGDESC

  def interface(file = DATA_FILE)
    data = JSON.parse File.read(file)
    puts data
  end

end