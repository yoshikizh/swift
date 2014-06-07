class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string  :name,      null: false
      t.text    :content,   null: false
      t.boolean :recommend, default: false
      t.references :user
      t.references :node
      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :node_id
  end
end
