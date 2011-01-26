module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg, :class => 'alert') }.join
    #sentence = "#{pluralize(resource.errors.count, "error")} prohibited this #{resource_name} from being saved:"

    html = <<-HTML
    <div id="flash-messages">
      <ul class="flash-messages-list">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end