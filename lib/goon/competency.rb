require 'goon'

class Goon::Competency
  class InvalidCompetency < Exception
  end

  attr_accessor :description
  attr_reader :name, :body

  def initialize(options = {})
    @name = options[:name].to_s
    @description = options[:description].to_s || "This competency has no description"
    @body = options[:body].to_s

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
    raise InvalidCompetency, "name cannot be nil" if @name.nil?
    raise InvalidCompetency, "name cannot be empty" if @name.gsub(/\s+/, '').empty?
    raise InvalidCompetency, "'#{@name}' is not a valid method name" unless (@name.to_sym.inspect =~ /[@$\"]/).nil?
  end

  def validate_body!
    raise InvalidCompetency, "body cannot be nil" if @body.nil?
    raise InvalidCompetency, "body cannot be blank" if @body.gsub(/\s+/, '').empty?
  end
end
