class Topic < ActiveRecord::Base
  validates :name,:content,  presence: true
  validates_length_of :name, :in => 6..64, message: "字数必须在 6 - 32 之间"
  belongs_to :user
  belongs_to :node
  has_many :replies, class_name: TopicReply, foreign_key: "topic_id"
end
