class TopicReply < ActiveRecord::Base
  validates :content,  presence: true
  validates_length_of :content, :minimum => 6, message: "至少6个字符"
  belongs_to :user
  belongs_to :topic
end
