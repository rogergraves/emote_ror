module ApplicationHelper

  def flash_alert
    return '' if alert.nil? || alert.empty?

    html = <<-HTML
    <div id="error_explanation">
      <ul class="errors_list"><li>#{alert}</li></ul>
    </div>
    HTML
    html.html_safe
  end

end
