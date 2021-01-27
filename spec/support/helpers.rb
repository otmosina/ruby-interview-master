# frozen_string_literal: true

module Helpers
  def parsed_body
    if respond_to?(:response_body)
      JSON.parse(response_body)
    else
      JSON.parse(response.body)
    end
  end

  def parsed_data
    parsed_body['data']
  end

  def parsed_included
    parsed_body['included']
  end

  def parsed_meta
    parsed_body['meta']&.symbolize_keys
  end

  def have_enqueued_email(mailer, action, params)
    have_enqueued_job(ActionMailer::Parameterized::DeliveryJob).with(mailer, action, "deliver_now", params)
  end

  def jsonapi_params(type: nil, attributes: {}, relationships: {})
    {
      _jsonapi: {
        data: {
          type: type,
          attributes: attributes,
          relationships: relationships
        }
      }
    }.with_indifferent_access
  end

  def sns_events
    App::Container['transports.aws.sns'].events
  end

  def socket_events
    App::Container['transports.socket'].events
  end

  def socket_event_names
    socket_events.map { |e| "#{e[:app_kind]}:#{e[:event]}" }
  end
end
