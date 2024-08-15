class AddStarToParks < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :star, :integer
  end
end
