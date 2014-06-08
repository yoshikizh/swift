class Node < ActiveRecord::Base
  validates :name,  presence: true
  validates_uniqueness_of :name
  has_many :topics

  NODES = {
    1 => %w{ 交流讨论 新手问题 原创技术 转载文章 新闻动态 },
    2 => %w{ 开源项目 原创项目 Swift游戏 },
    3 => %w{ 发布招聘 我要求职 },
    4 => %w{ 灌水闲聊 },
    5 => %w{ 我要反馈 站内事物 }
  }

  def self.all_nodes
    NODES.values.flatten
  end

  def self.find_id_by_tag(_tag)
    NODES.find{|k,v| v.include?(_tag)}.first
  end
end
