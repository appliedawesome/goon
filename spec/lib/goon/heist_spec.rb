require 'spec_helper'
require 'goon/heist'

describe Goon::Heist do
  before(:each) do
    @heist = Goon::Heist.new(
      :name => 'boogie woogie',
      :body => 'true'
    )
  end

  describe "#name" do
    it "is a reader" do
      @heist.should respond_to(:name)
    end

    it "is a string" do
      @heist.name.should be_a(String)
    end
  end

  describe '#name=' do
    it "should set the name to the given value" do
      oldname = @heist.name
      lambda {@heist.name = 'booga wooga'}.should_not raise_error
      @heist.name.should_not == oldname
      @heist.name.should == 'booga wooga'
    end

    it "should take exception to bad names" do
      [nil, '', '      ', "\n\t\n"].each do |bad_name|
        lambda { @heist.name = bad_name}.should raise_error(Goon::Heist::InvalidHeist)
      end
    end
  end

  describe '#body' do
    it 'is a reader' do
      @heist.should respond_to(:body)
    end

    it 'is a string' do
      @heist.body.should be_a(String)
    end
  end

  describe '#body=' do
    it 'should set the body to the provided value' do
      oldbody = @heist.body
      lambda {@heist.body = 'false'}.should_not raise_error
      @heist.body.should_not == oldbody
      @heist.body.should == 'false'
    end

    it 'should take exception to bad bodies' do
      [nil, '', '      ', "\n\t\n"].each do |bad_body|
        lambda { @heist.body = bad_body}.should raise_error(Goon::Heist::InvalidHeist)
      end
    end
  end

end
