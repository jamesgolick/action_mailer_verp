require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActionMailerVerp" do
  class MyMailer < ActionMailer::Base
    include ActionMailerVerp::VERPMail
    prepend_view_path File.dirname(__FILE__) + "/templates"

    def some_mail(address)
      mail :from    => "MyCompany <donotreply@mycompany.com>",
           :to      => address,
           :subject => "An exciting new email from MyCompany"
    end

    def multiple_froms
      mail :from    => ["MyCompany <donotreply@mycompany.com>", "AnotherFrom <asdf@bsdf.com>"],
           :to      => "asdf@bsdf.com",
           :subject => "An exciting new email from MyCompany"
    end

    def multiple_recipients
      mail :from    => "MyCompany <donotreply@mycompany.com>",
           :to      => ["asdf@bsdf.com", "bsdf@csdf.com"],
           :subject => "An exciting new email from MyCompany"
    end
  end

  describe "ActionMailerVerp::VERPMail" do
    describe "with one from address" do
      before do
        @mail = MyMailer.some_mail("james@example.com")
      end

      it "sets the return-path to the VERP address" do
        addr = @mail['return-path'].value.split(/@/)
        addr.first.should == "donotreply+james=example.com"
        addr.last.should == "mycompany.com"
      end
    end

    describe "with multiple from addresses" do
      it "raises an error because that is not supported" do
        lambda {
          MyMailer.multiple_froms
        }.should raise_error(ActionMailerVerp::VERPMail::MultipleFromsError)
      end
    end

    describe "with multiple recipients" do
      it "raises an error because that is not supported" do
        lambda {
          MyMailer.multiple_recipients
        }.should raise_error(ActionMailerVerp::VERPMail::MultipleRecipientsError)
      end
    end
  end
end
