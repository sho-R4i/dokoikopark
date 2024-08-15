class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :park, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    
    add_index :post_tags, [:park_id, :tag_id], unique: true
  end
end
