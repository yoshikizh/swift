class HomeController < ApplicationController
  def index
    node_name = params[:node_name] || "node1"
    @node = Node.where(name: node_name).first
    if params[:keyword].present?
      @topics = Topic.where(["name LIKE ?","%#{params[:keyword]}%"]).page(params[:page]).per(15)
    else
      @topics = @node.topics.order("updated_at desc").page(params[:page]).per(15)
    end
  end
end
