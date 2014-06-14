class CreateMyads < ActiveRecord::Migration
  def change
    create_table :myads do |t|
      t.string :title
      t.text :description
      t.integer :typead_id

      t.timestamps
    end
  end
end
