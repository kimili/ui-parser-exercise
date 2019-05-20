class UIParser

  def initialize(data)
    @data = data
  end

  def parse(selector)
    find selector
  end

  private

  def find(selector)
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
    output[:selector] = format_selector(object)
    output[:label] = object['label']['text']['text'] if object.key?('label')
    output
  end

  def format_selector(object)
    selector = object['class'] || ''
    selector += "##{object['identifier']}" if object.key?('identifier')
    selector += ".#{object['classNames'].join('.')}" if object.key?('classNames') && object['classNames'].is_a?(Array)
    selector
  end

end