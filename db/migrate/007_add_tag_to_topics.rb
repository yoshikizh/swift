class AddTagToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :tag, :string
    add_index :topics, :tag
  end
end
