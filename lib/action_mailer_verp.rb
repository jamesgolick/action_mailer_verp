require 'actionmailer'

module ActionMailerVerp
  module FromRewriter
    class MultipleFromsError < ArgumentError; end
    class MultipleRecipientsError < ArgumentError; end

    def self.included(klass)
      klass.send(:alias_method_chain, :create_mail, :verp)
    end

    def create_mail_with_verp
      create_mail_without_verp
      verpify_from(@mail)
      @mail
    end

    private
      def verpify_from(mail)
        if mail.from_addrs.length > 1
          raise MultipleFromsError, "Multiple from addresses not supported."
        end

        if mail.to.length > 1
          raise MultipleRecipientsError, "Multiple recipients not supported."
        end

        from      = mail.from_addrs.first
        local     = "#{from.local}+#{mail.to.first.gsub("@", "=")}"
        mail.from = "#{from.name} <#{local}@#{from.domain}>"
      end
  end
end
