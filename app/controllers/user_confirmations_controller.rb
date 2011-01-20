class UserConfirmationsController < Devise::ConfirmationsController

  # GET /user/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message :notice, :confirmed
      #sign_in_and_redirect(resource_name, resource)
      self.resource.make_reset_password_token!
    else
      render_with_scope :new
    end
  end

end
