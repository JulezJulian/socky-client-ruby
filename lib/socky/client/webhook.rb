require 'multi_json'

module Socky
  class Client
    class Webhook

    	# Initializes a new Webook with a Rack::Request.
    	#
      def initialize(request)
        @hash = request.headers["data-hash"]

        request.body.rewind
        @body = request.body.read
        request.body.rewind

        puts 'hash: ' + @hash.to_s + ' body: ' + @body.to_s
      end

      # Determines if the received webhook data is valid by checking the hash
      #
		def valid?
		  return false if @hash.nil? || @body.nil?

		  salt, expected_hash = @hash.split(':',2)
		  puts 'salt: ' + salt.to_s + ' exp: ' + expected_hash.to_s

		  data_to_sign = [salt, @body].collect(&:to_s).join(':')

		  digest = OpenSSL::Digest::SHA256.new
		  received_data_hash = OpenSSL::HMAC.hexdigest(digest, 'my_secret', data_to_sign)

		  return expected_hash.eql?(received_data_hash)
		end

		# Returns the data the webhook received.
		#
		def data
			MultiJson.load(@body)
		end
    end
  end
end
