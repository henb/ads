class CreateTypeads < ActiveRecord::Migration
  def change
    create_table :typeads do |t|
      t.string :name
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
