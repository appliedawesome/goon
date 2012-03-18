require 'spec_helper'
require 'goon'

describe Goon do
  it "should know its version" do
    Goon::VERSION.should_not be_nil
  end

  describe '#competencies' do
    before(:each) do
      @goon = Goon.new
    end

    it "is a reader" do
      @goon.should respond_to(:competencies)
    end

    it "is an array" do
      @goon.competencies.should be_a(Array)
    end
  end

  describe '#task' do
    it "is a reader" do
      Goon.new.should respond_to(:task)
    end

    context "when the Goon has been given a Task" do
      it "conforms to the Task API" do
        task = Goon.new(:task => OpenStruct.new(:name => 'blah', :body => 'poop')).task
        task.should respond_to(:name)
        task.should respond_to(:body)
        task.body.should be_a(String)
      end
    end

    context "when the Goon has not been given a task" do
      it "is nil" do
        Goon.new.task.should be_nil
      end
    end
  end

  describe '#facts' do
    it "provides a reader for facts" do
      Goon.new.should respond_to(:facts)
    end
    it "is a hash" do
      Goon.new.facts.should be_a(Hash)
    end
  end
  
  describe '#learn_competency' do
    before(:each) do
      @competency = OpenStruct.new(:name => 'hello', :body => 'puts "hello"')
      @goon = Goon.new
    end

    it "records the provided competency" do
      @goon.competencies.should_not include(@competency)
      @goon.learn_competency(@competency)
      @goon.competencies.should include(@competency)
    end

    it "learns the provided competency" do
      @goon.should_not respond_to(@competency.name.to_s)
      @goon.learn_competency(@competency)
      @goon.should respond_to(@competency.name.to_s)
    end
  end

  describe '#learn_competencies' do
    before(:each) do
      @test_competencies = []
      1.upto(10) do |number|
        @test_competencies.push OpenStruct.new(:name => "competency#{number}", :body => "puts number")
      end
      @goon = Goon.new
    end

    it "records the provded competencies" do
      @test_competencies.each do |competency|
        @goon.competencies.should_not include(competency)
      end

      @goon.learn_competencies(@test_competencies)
      
      @test_competencies.each do |competency|
        @goon.competencies.should include(competency)
      end
    end

    it "learns the provided competencies" do
      @test_competencies.each do |competency|
        @goon.should_not respond_to(competency.name.to_s)
      end

      @goon.learn_competencies(@test_competencies)

      @test_competencies.each do |competency|
        @goon.should respond_to(competency.name.to_s)
      end
    end
  end

  describe '#remember' do
    it "records the given hash as facts" do
      goon = Goon.new
      goon.facts.should be_empty
      goon.remember :blah => 'poop'
      goon.facts.should_not be_empty
    end
  end

  describe '#recall' do
    it "returns the body of the requested fact" do
      goon = Goon.new(:facts => {:blah => 'poop'})
      goon.recall(:blah).should == 'poop'
    end
  end

  describe '#forget' do
    it 'removes the specified fact' do
      goon = Goon.new(:facts => {:blah => 'poop'})
      goon.recall(:blah).should == 'poop'
      goon.forget(:poop)
      goon.recall(:poop).should be_nil
    end
  end

  describe '#run' do
    before(:each) do
      @task = OpenStruct.new(
        :name => "Blah ... Poop ...",
        :body => <<-EOS
          remember :blah => 'poop'
        EOS
      )
      @goon = Goon.new(:task => @task)
    end

    it "should run the task" do
      @goon.expects(:instance_eval).with(@task.body)
      @goon.run
    end

    it "should return its facts" do
      result = @goon.run
      result.should be_a(Hash)
      result.should_not be_empty
      result.should == @goon.facts
    end
  end
end
