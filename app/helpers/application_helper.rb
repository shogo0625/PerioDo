module ApplicationHelper
  def bootstrap_alert(name)
    case name
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    when "warning"
      "warning"
    when "success"
      "success"
    when "danger"
      "danger"
    end
  end

  def call_user_img(user)
    if user.profile_image_id.nil?
      image_url = "noimage.png"
      image_url
    else
      image_url = "https://portfolio-resize.s3-ap-northeast-1.amazonaws.com/store/" + user.profile_image_id + "-thumbnail."
      image_url
    end
  end

  def call_post_img(post)
    image_url = "https://portfolio-resize.s3-ap-northeast-1.amazonaws.com/store/" + post.image_id + "-thumbnail."
    image_url
  end
end
