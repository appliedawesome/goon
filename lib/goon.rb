require 'goon/version'

class Goon
  attr_reader :competencies, :heist, :facts

  def initialize(options = {})
    competencies = options[:competencies] || []
    @competencies = []
    @heist = options[:heist]
    @facts = options[:facts] || {}
    learn_competencies(competencies)
  end

  def learn_competency(competency)
    unless @competencies.include? competency
      instance_eval <<-EOS
      def #{competency.name}(options = {})
        #{competency.body}
      end
      EOS
      @competencies << competency
    end
  end

  def learn_competencies(competencies)
    competencies.each do |competency|
      learn_competency(competency)
    end
  end

  #def unlearn_competency(name)
    #instance_eval "undef #{name}"
    #@competencies.delete(@competencies.select {|x| x.name == name}.first)
  #end

  #def unlearn_competencies
    #@competencies.each do |competency|
      #unlearn_competency(competency.name)
    #end
  #end

  def remember(options = {})
    @facts.merge!(options)
  end

  def recall(name)
    @facts[name]
  end

  def forget(name)
    @facts.delete(name)
  end

  def run
    instance_eval @heist.body
    @facts
  end
end
