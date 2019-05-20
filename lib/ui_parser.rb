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
    @data = JSON.parse File.read(file)
    say 'User Interface Data has been loaded and is ready to parse'

    loop do
      result = ask 'Enter a selector:'
      break if result =~ /^bye|exit|done|quit|end$/i
      
      pp parse result
    end
  end

  private

  def parse(selector)
    selector = selector.strip
    key = case selector
          when /^\./
            'classNames'
          when /^#/
            'identifier'
          else
            'class'
          end
    deep_find key, selector.gsub(/^[\.#]/, ''), @data
  end

  def deep_find(key, value, object, found = [])
    if object.respond_to?(:key?) && object.key?(key)
      if object[key].is_a? String
        found << format(object) if object[key] == value
      elsif object[key].is_a? Array
        found << format(object) if object[key].include? value
      end
    end
    found << object.collect { |*a| deep_find(key, value, a.last) } if object.is_a? Enumerable
    found.flatten.compact
  end

  def format(object)
    output = {}
    output[:selector] = get_selector(object)
    output[:label] = object['label']['text']['text'] if object.key?('label')
    output
  end

  def get_selector(object)
    selector = object['class'] || ''
    selector += "##{object['identifier']}" if object.key?('identifier')
    selector += ".#{object['classNames'].join('.')}" if object.key?('classNames') && object['classNames'].is_a?(Array)
    selector
  end

end