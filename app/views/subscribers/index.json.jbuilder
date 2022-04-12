# frozen_string_literal: true

json.array! @subscribers, partial: 'subscribers/subscriber', as: :subscriber
