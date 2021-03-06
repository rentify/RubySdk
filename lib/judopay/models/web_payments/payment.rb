require_relative '../../model'

module Judopay
  module WebPayments
    class Payment < Model
      @resource_path = 'webpayments/payments'
      @valid_api_methods = [:create]

      attribute :judo_id, String
      attribute :amount, Float
      attribute :partner_service_fee, Float
      attribute :your_consumer_reference, String
      attribute :your_payment_reference, String
      attribute :your_payment_meta_data, Hash
      attribute :client_ip_address, String
      attribute :client_user_agent, String

      validates_presence_of :judo_id,
                            :your_consumer_reference,
                            :your_payment_reference,
                            :amount
    end
  end
end
