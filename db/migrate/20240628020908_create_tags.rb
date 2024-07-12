class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :park, null: false, foreign_key: true
      t.string :tag_name

      t.timestamps
    end
  end
end
