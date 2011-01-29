module ApplicationHelper

  def flash_messages(opts = {})
    show_alert = (opts.has_key?(:alert) ? opts[:alert] : true) && !alert.blank?
    show_notice = (opts.has_key?(:notice) ? opts[:notice] : true) && !notice.blank?

    return '' unless show_notice || show_alert

    html = <<-HTML
    <div id="flash-messages">
      <ul class="flash-messages-list">
        #{show_notice ? content_tag(:li, notice, :class => 'notice') : ''} #{show_alert ? content_tag(:li, alert, :class => 'alert') : ''}
      </ul>
    </div>
    HTML
    html.html_safe
  end

  def errors_for(ar_instance)
    return '' unless ar_instance.errors.any?
    messages = ar_instance.errors.full_messages.map { |msg| content_tag(:li, msg, :class => 'alert') }.join
    html = <<-HTML
    <div id="flash-messages">
      <ul class="flash-messages-list">#{messages}</ul>
    </div>
    HTML
    html.html_safe
  end

end
