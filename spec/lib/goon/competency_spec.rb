require 'spec_helper'
require 'goon/competency'

describe Goon::Competency do
  before(:each) do
    @competency = Goon::Competency.new(
      :name => "competency1",
      :body => "true"
    )
  end

  describe "#name" do
    it "is a reader" do
      @competency.should respond_to(:name)
    end

    it "is a string" do
      @competency.name.should be_a(String)
    end
  end

  describe '#name=' do
    it "should set the name to the given value" do
      oldname = @competency.name
      lambda {@competency.name = 'howdy'}.should_not raise_error
      @competency.name.should_not == oldname
      @competency.name.should == 'howdy'
    end

    it "should take exception to bad names" do
      [nil, ' blah', 'bl!ah', '@blah', '$blah', '0blah'].each do |bad_name|
        lambda { @competency.name = bad_name}.should raise_error(Goon::Competency::InvalidCompetency)
      end
    end
  end

  describe '#body' do
    it 'is a reader' do
      @competency.should respond_to(:body)
    end

    it 'is a string' do
      @competency.body.should be_a(String)
    end
  end

  describe '#body=' do
    it 'should set the body to the provided value' do
      oldbody = @competency.body
      lambda {@competency.body = 'false'}.should_not raise_error
      @competency.body.should_not == oldbody
      @competency.body.should == 'false'
    end

    it 'should take exception to bad bodies' do
      [nil, '', '      ', "\n\t\n"].each do |bad_body|
        lambda { @competency.body = bad_body}.should raise_error(Goon::Competency::InvalidCompetency)
      end
    end
  end

  describe "#description" do
    it "is an accessor" do
      @competency.should respond_to(:description)
      @competency.should respond_to(:description=)
    end
  end
end
