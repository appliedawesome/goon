require 'goon'

class Goon::Task
  class InvalidTask < Exception
  end

  attr_reader :name, :body

  def initialize(options = {})
    @name = options[:name]
    @description = options[:description]
    @body = options[:body]

    validate_name!
    validate_body!
  end

  def name=(new_name)
    @name = new_name
    validate_name!
  end

  def body=(new_body)
    @body = new_body
    validate_body!
  end

  private

  def validate_name!
    raise InvalidTask, "name cannot be nil" if @name.nil?
    raise InvalidTask, "name cannot be blank" if @name.gsub(/\s+/, '').empty?
  end

  def validate_body!
    raise InvalidTask, "body cannot be nil" if @body.nil?
    raise InvalidTask, "body cannot be blank" if @body.gsub(/\s+/, '').empty?
  end
end
