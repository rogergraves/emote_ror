class AccountsController < ApplicationController
  
  def edit
    @account = current_user
  end
  
  def update
    if params[:account][:password].blank?
      params[:account].delete(:password)
      params[:account].delete(:password_confirmation)
    end
    @account = current_user
    if @account.update_attributes params[:account]
       flash[:notice] = 'Account information successfuly saved'
    end
    render :action => 'edit'
  end


  def settings
    settings = [:activity_report_interval]
    if request.post?
      settings.each do |setting|
        current_user.send("#{setting}=", params[setting]) if params[setting]
      end
      render :status => 200, :text => current_user.save ? 'ok' : "Error: #{current_user.errors.full_messages.first}"
    else
      render :json => settings.inject({}){|hsh, setting| hsh[setting] = current_user.send(setting); hsh }
    end
  end

end
