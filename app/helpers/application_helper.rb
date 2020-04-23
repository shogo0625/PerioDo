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
end
