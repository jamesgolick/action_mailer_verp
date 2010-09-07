module ActionMailerVerp
  class BounceProcessor
    def initialize(fetcher)
      @fetcher = fetcher
    end

    def each
      @fetcher.each do |email|
        local = email.to_addrs.first.local
        yield local.split("+").last.gsub("=", "@")
      end
    end
  end
end
