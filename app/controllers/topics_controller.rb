class TopicsController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  def create
    @topic = Topic.new params.require(:topic).permit(:name,:content)
    @topic.user = current_user
    @topic.node_id = params[:node_id].to_i
    @topic.tag = params[:tag]
    current_user.add_point(10)
    if @topic.save
      redirect_to node_topic_path(@topic.node_id,@topic),notice: "感谢您发表主题 ~ 积分 + 10"
    else
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes params.require(:topic).permit(:name,:content)
    @topic.tag = params[:tag]
    if @topic.save
      redirect_to node_topic_path(@topic.node_id,@topic),notice: "保存成功"
    else
      render :edit
    end
  end
end