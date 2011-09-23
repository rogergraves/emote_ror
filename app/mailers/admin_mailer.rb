class AdminMailer < ActionMailer::Base
  layout "email"
  default :from => "delivery@inspirationengine.com"

  def signup(user)
    @user = user
    include_images!
    mail :to => 'signups@inspirationengine.com', :subject => "New customer"
  end

  def upgrade(user, payment)
    @user = user
    @payment = payment
    include_images!
    mail :to => 'sales@inspirationengine.com', :subject => "Customer plan upgraded"
  end

private
  def include_images!
    attachments.inline['header_full.png'] = File.open("#{Rails.root}/public/images/emote_logo.png", 'rb'){|f| f.read}
  end

end
