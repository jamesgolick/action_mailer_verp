require 'action_mailer'
require 'action_mailer_verp/bounce_processor'
require 'action_mailer_verp/pop_fetcher'

module ActionMailerVerp
  module VERPMail
    class MultipleFromsError < ArgumentError; end
    class MultipleRecipientsError < ArgumentError; end

    def mail(*args, &block)
      m = super
      verpify(m)
      m
    end

    private
      def verpify(mail)
        if mail.from_addrs.length > 1
          raise MultipleFromsError, "Multiple from addresses not supported."
        end

        if mail.to.length > 1
          raise MultipleRecipientsError, "Multiple recipients not supported."
        end

        from_parts          = mail.from_addrs.first.split(/@/)
        from_local          = from_parts.first
        from_domain         = from_parts.last
        local               = "#{from_local}+#{mail.to.first.gsub("@", "=")}"
        return_path         = "#{local}@#{from_domain}"
        mail['return-path'] = return_path
      end
  end
end
