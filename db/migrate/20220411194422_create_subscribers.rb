class CreateSubscribers < ActiveRecord::Migration[7.0]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false, default: ""

      t.timestamps
    end
    add_index :subscribers, :email, unique: true
  end
end
