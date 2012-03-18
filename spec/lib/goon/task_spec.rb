require 'spec_helper'
require 'goon/task'

describe Goon::Task do
  before(:each) do
    @task = Goon::Task.new(
      :name => 'boogie woogie',
      :body => 'true'
    )
  end

  describe "#name" do
    it "is a reader" do
      @task.should respond_to(:name)
    end

    it "is a string" do
      @task.name.should be_a(String)
    end
  end

  describe '#name=' do
    it "should set the name to the given value" do
      oldname = @task.name
      lambda {@task.name = 'booga wooga'}.should_not raise_error
      @task.name.should_not == oldname
      @task.name.should == 'booga wooga'
    end

    it "should take exception to bad names" do
      [nil, '', '      ', "\n\t\n"].each do |bad_name|
        lambda { @task.name = bad_name}.should raise_error(Goon::Task::InvalidTask)
      end
    end
  end

  describe '#body' do
    it 'is a reader' do
      @task.should respond_to(:body)
    end

    it 'is a string' do
      @task.body.should be_a(String)
    end
  end

  describe '#body=' do
    it 'should set the body to the provided value' do
      oldbody = @task.body
      lambda {@task.body = 'false'}.should_not raise_error
      @task.body.should_not == oldbody
      @task.body.should == 'false'
    end

    it 'should take exception to bad bodies' do
      [nil, '', '      ', "\n\t\n"].each do |bad_body|
        lambda { @task.body = bad_body}.should raise_error(Goon::Task::InvalidTask)
      end
    end
  end

end
