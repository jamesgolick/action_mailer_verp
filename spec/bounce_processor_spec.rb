require 'spec_helper'

describe "BounceProcessor" do
  class FakeFetcher
    def initialize(*fetches)
      @fetches = fetches
    end

    def each
      @fetches.each { |f| yield f }
    end
  end

  class Email < Struct.new(:to_addrs); end

  class Address < Struct.new(:local); end

  before do
    @fetcher   = FakeFetcher.new(Email.new([Address.new("donotreply+asdf=bsdf.com")]))
    @processor = ActionMailerVerp::BounceProcessor.new(@fetcher)
  end

  it "yields the email address converted from VERP form to normal" do
    yielded = []
    @processor.each { |a| yielded << a }
    yielded.should == ["asdf@bsdf.com"]
  end
end
