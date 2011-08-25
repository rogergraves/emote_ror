class UserMailer < Devise::Mailer
  layout "email"

private
  def include_images!
    %w(header_full.png).each do |file|
     attachments.inline[file] = File.open("#{Rails.root}/public/images/email/#{file}", 'rb'){|f| f.read}
    end
  end

  def devise_mail(record, action)
    include_images!
    super(record, action)
  end
  alias_method :setup_mail, :devise_mail

end
