class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.boolean :women, default: false
      t.boolean :men, default: false
      t.boolean :children, default: false

      t.timestamps
    end
  end
end
