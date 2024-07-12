class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :park_name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :park_introduction

      t.timestamps
    end
  end
end
