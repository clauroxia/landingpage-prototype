# frozen_string_literal: true

class CreateJoinTablePreferencesSubscriber < ActiveRecord::Migration[7.0]
  def change
    create_join_table :preferences, :subscribers do |t|
      # t.index [:preference_id, :subscriber_id]
      # t.index [:subscriber_id, :preference_id]
    end
  end
end
