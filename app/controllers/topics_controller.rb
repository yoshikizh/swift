class TopicsController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  def create
    @topic = Topic.new params.require(:topic).permit(:name,:content)
    @topic.user = current_user
    @topic.node_id = params[:node_id].to_i
    @topic.tag = params[:tag]
    current_user.add_point(10)
    if @topic.save
      redirect_to "/#{@topic.node.name}",notice: "感谢您发表主题 ~ 积分 + 10"
    else
      render :new
    end
  end
end