module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    #sentence = "#{pluralize(resource.errors.count, "error")} prohibited this #{resource_name} from being saved:"

    html = <<-HTML
    <div id="error_explanation">
      <ul class="errors_list">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end