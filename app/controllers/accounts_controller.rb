class AccountsController < ApplicationController
  before_filter :authenticate_user!
  
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
       
    else
      
    end
    
    render :action => 'edit'
  end
end
