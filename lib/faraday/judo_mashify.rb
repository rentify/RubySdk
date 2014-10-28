require 'faraday_middleware/response/rashify'
require_relative '../judopay/mash'

# @private
module FaradayMiddleware
  # Convert parsed response bodies to a Hashie::Rash if they are a Hash or Array
  class JudoMashify < Rashify
    dependency do
      # require 'rash'
      self.mash_class = ::Judopay::Mash
    end
  end
end


module Judopay
  module FaradayMiddleware
    class Mashify < Faraday::Response::Middleware
      attr_accessor :mash_class

      class << self
        attr_accessor :mash_class
      end

      dependency do
        require 'hashie/mash'
        self.mash_class = ::Hashie::Mash
      end

      def initialize(app = nil, options = {})
        super(app)
        self.mash_class = options[:mash_class] || self.class.mash_class
      end

      def parse(body)
        case body
        when Hash
          mash_class.new(body)
        when Array
          body.map { |item| parse(item) }
        else
          body
        end
      end
    end

    class Judoify < Mashify
      dependency do
        # require 'rash'
        self.mash_class = ::Judopay::Mash
      end
    end
  end
end