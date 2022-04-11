class SuscribersPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :subscribers_preferences do |t|
      t.references :subscribers, null: false, foreign_key: true
      t.references :preferences, null: false, foreign_key: true

      t.timestamps
    end
  end
end
