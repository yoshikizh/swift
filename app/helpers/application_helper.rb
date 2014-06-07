require 'avatar/view/action_view_support'
module ApplicationHelper
  include Avatar::View::ActionViewSupport

  def savatar(user,asize,options={})
    s = {:small => "32",:medium => "64",:large=>"128"}
    size = s[asize] ? s[asize] : "64"
    size = options[:force] if options[:force]
    return case user.avatar_from
    when 1
      avatar_tag(user, :size => size.to_i)
    when 2
      image_tag user.avatar.send(asize),:size=>"#{size}x#{size}"
    end
  end

  def user_avatar_tag(user,size)
    h = {:small => "32",:medium => "64",:large=>"128"}
    if size.is_a?(Integer)
      _size = size
    elsif h.include?(size)
      _size = h[size]
    else
      _size = 64
    end
    _avatar_url = user.avatar_url ? user.avatar_url : "avatar-default.jpg"
    image_tag _avatar_url,:size=>"#{_size}x#{_size}"
  end

  def from_now(t)
    s = t - Time.now
    day = (s / 86400).to_i
    hour = ((s % 86400) / 3600).to_i
    min = (s % 86400).to_i % 3600 / 60
    return day,hour,min
  end

  def before_now(t)
    limit = Time.now.to_i - t.to_i
    if limit <=0
      '1秒前'
    elsif limit < 60
      "#{limit}秒前"
    elsif limit >=60 && limit < 3600
      (limit/60).to_i.to_s + "分钟前"
    elsif limit >=3600 && limit < 86400
      (limit/3600).to_i.to_s + " 小时前"
    elsif limit >= 86400 && limit < 259200
      (limit/86400).to_i.to_s + "天之前"
    elsif limit >= 259200
      t.strftime('%m-%d %H:%M')
    else
      ''
    end
  end

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def assets_resource
    arr = params[:controller].split("/")
    arr.size > 1 ? "controller/#{arr.first}/#{arr.last}" : "controller/#{arr.first}"
  end

  def asset_exist?(dir,filename)
    File.exist? File.expand_path("app/assets/#{dir.to_sym}/#{filename}")
  end

  def markdown(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
      }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
    markdown.render(h(text)).html_safe
  end
end
