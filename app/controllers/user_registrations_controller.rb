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
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render_with_scope :edit }
    end
  end

  
  #Overrides the path where user is redirected after initial password setup
  def after_update_path_for(resource_or_scope)
    if resource_or_scope.kind_of?(User)
      new_account_survey_path
    else #Admins [for future]
      super(resource_or_scope)
    end
  end

end
