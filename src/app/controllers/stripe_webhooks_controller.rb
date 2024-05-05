class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handler
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :endpoint_secret)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # Invalid payload
      logger.error(e)
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'product.created'
      event.data.object
    # ... handle other event types
    else
      logger.debug("Unhandled event type: #{event.type}")
    end
  end
end
