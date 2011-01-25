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

  def errors_for(ar_instance)
    return '' unless ar_instance.errors.any?
    messages = ar_instance.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div id="error_explanation">
      <ul class="errors_list">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

end
