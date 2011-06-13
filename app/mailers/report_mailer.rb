class ReportMailer < ActionMailer::Base
  layout "email"
  default :from => "no-reply@inspirationengine.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.emote_activity.subject
  #
  def emote_activity(user)
    @user = user
    include_images!
    mail :to => @user.email, :subject => "e.mote Activity Update"
    @user.update_attribute(:activity_report_sent_at, DateTime.now)
  end


private
  def include_images!
    %w(header_full.png).each do |file|
     attachments.inline[file] = File.open("#{Rails.root}/public/images/email/#{file}", 'rb'){|f| f.read}
    end
  end

end
