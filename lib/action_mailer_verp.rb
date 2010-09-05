require 'actionmailer'

module ActionMailerVerp
  module FromRewriter
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
        from      = mail.from_addrs.first
        local     = "#{from.local}+#{mail.to.first.gsub("@", "=")}"
        mail.from = "#{from.name} <#{local}@#{from.domain}>"
      end
  end
end
