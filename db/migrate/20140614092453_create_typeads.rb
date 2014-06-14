class CreateTypeads < ActiveRecord::Migration
  def change
    create_table :typeads do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
