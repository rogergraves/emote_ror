class Admin::AccountsController < Admin::BaseController

  sortable_table User,
    :per_page => 50,
    :table_headings => [
      ['ID', 'id'],
      ['Email', 'email', :edit],
      ['Name', 'full_name'],
      ['Title', 'job_title'],
      ['Company', 'company'],
      ['Login count', 'sign_in_count'],
      ['Last login', 'last_sign_in_at'],
      ['eMotes', 'surveys.count'],
      ['Plan', 'plan.kind'],
      ['Partner code', 'partner_code']
    ],
    :sort_map =>  {
      'id' => ['users.id'],
      'email' => ['users.email'],
      'full_name' => ['users.full_name'],
      'job_title' => ['users.job_title'],
      'company' => ['users.company'],
      'sign_in_count' => ['users.sign_in_count'],
      'last_sign_in_at' => ['users.last_sign_in_at'],
      'surveys.count' => ['surveys_count'],
      'plan.kind' => ['subscriptions.kind'],
      'partner_code' => ['users.partner_code']
    },
    :search_array => ['users.email', 'users.full_name', 'users.job_title', 'users.company']

  def index
    if request.xhr?
      @users = User.paginate(:select => 'id, email', :page => params[:page])
      table = ['<table cellpadding="10" cellspacing="10"><tr>']
      @users.each_with_index do |user, index|
        table << "<td><a href='##{user.id}' class='user-item'>#{user.email}</a></td>"
        table << '</tr><tr>' if index!=0 && (index+1)%2==0
      end
      table << '</tr></table>'
      #table << will_paginate(@users)
      render :text => table.join("\n")
    else
      get_sorted_objects(params)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.skip_confirmation!
    if @user.save
      flash[:notice] = "User #{@user.email} successfully saved"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error saving user'
      render :new
    end
  end

  def edit
     @user = User.find(params[:id])
     @note = Note.new
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    if @user.update_attributes params[:user]
      flash[:notice] = "User #{@user.email} successfully saved"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error saving user'
      @note = Note.new
      render :edit
    end
  end
  
  def add_note
    @user = User.find(params[:id])
    @note = Note.new params[:note]
    @note.creator = current_admin
    @note.subject = @user
    if @note.save
      flash[:notice] = 'Note added'
      @note = Note.new
      @user.reload
    else
      flash[:alert] = 'Error adding note'
    end
    render :edit
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User #{@user.email} successfully deleted"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error deleting user'
      render :edit
    end
  end

end
