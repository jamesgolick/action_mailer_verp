require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActionMailerVerp" do
  class MyMailer < ActionMailer::Base
    include ActionMailerVerp::FromRewriter
    self.template_root = File.dirname(__FILE__) + "/templates"

    def some_mail(address)
      from "MyCompany <donotreply@mycompany.com>"
      recipients address
      subject "An exciting new email from MyCompany"
    end

    def multiple_froms
      from ["MyCompany <donotreply@mycompany.com>", "AnotherFrom <asdf@bsdf.com>"]
      recipients "asdf@bsdf.com"
      subject "An exciting new email from MyCompany"
    end
  end

  describe "ActionMailerVerp::FromRewriter" do
    describe "with one from address" do
      before do
        @mail = MyMailer.create_some_mail("james@example.com")
      end

      it "rewrites the from address to be VERP compatible" do
        addr = @mail.from_addrs.first
        addr.local.should == "donotreply+james=example.com"
        addr.domain.should == "mycompany.com"
        addr.name.should == "MyCompany"
      end
    end
    
    describe "with multiple from addresses" do
      it "raises an error because that is not supported" do
        lambda {
          MyMailer.create_multiple_froms
        }.should raise_error(ActionMailerVerp::FromRewriter::MultipleFromsError)
      end
    end
  end
end
