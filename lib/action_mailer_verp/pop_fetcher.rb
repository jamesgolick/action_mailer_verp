require 'net/pop'

module ActionMailerVerp
  class PopFetcher
    include Enumerable

    def initialize(host, username, password)
      @host     = host
      @username = username
      @password = password
    end

    def connection
      if @connection.nil?
        @connection = Net::POP3.new(@host)
        @connection.start(@username, @password)
      end

      @connection
    end

    def each
      connection.each_mail do |e|
        yield e.pop
        e.delete
      end
      connection.finish
    end
  end
end
