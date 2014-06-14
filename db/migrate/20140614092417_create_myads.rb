class CreateMyads < ActiveRecord::Migration
  def change
    create_table :myads do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.integer :typead_id, null: false

      #state_machine
      t.integer :state
      t.index :state
      t.text :admin_message

      t.timestamps
    end
  end
end
