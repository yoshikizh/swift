class TopicRepliesController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  def create
    @reply = TopicReply.new params.require(:topic_reply).permit(:content,:topic_id,:user_id)
    @reply.topic.update_attributes :updated_at => Time.now
    current_user.add_point(3)
    if @reply.save
      redirect_to node_topic_path(params[:node_id],params[:topic_id]),notice: "感谢您的回复 ~ 积分 + 3"
    else
      redirect_to node_topic_path(params[:node_id],params[:topic_id]),alert: @reply.errors.full_messages.join("\r\n")
    end
  end
end
