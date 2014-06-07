class CreateTopicReplies < ActiveRecord::Migration
  def change
    create_table :topic_replies do |t|
      t.text :content, null: false
      t.references :user
      t.references :topic
      t.timestamps
    end
    add_index :topic_replies, :user_id
    add_index :topic_replies, :topic_id
  end
end
