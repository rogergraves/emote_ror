class UserRegistrationsController < Devise::RegistrationsController

  # POST /resource/sign_up
  def create
    build_resource
    resource.password = resource.password_confirmation = rand(Time.now.to_i).to_s(24) #Password auto-generated
    if resource.save
      set_flash_message :notice, :signed_up
      #sign_in_and_redirect(resource_name, resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  # PUT /resource
  def update
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

end
