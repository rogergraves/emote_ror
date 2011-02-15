class Admin::EmotesController < Admin::BaseController

  sortable_table Survey,
    :per_page => 50,
    :default_sort => ['user.email', 'DESC'],
    :table_headings => [
      ['Customer', 'user.email'],
      ['e.mote NAME', 'project_name', :edit],
      ['Code', "code", :code],
      ['STATE', 'state_human'],
      ['START DATE', "created_at"],
      ['RESPONSES', "responses_count"]
    ],
    :include_relations => [:user],
    :sort_map =>  {
      'user.email' => ['users.email'],
      'project_name' => ['surveys.project_name'],
      'code' => ['surveys.code'],
      'created_at' => ['surveys.created_at'],
      'state_human' => ['surveys.state'],
      'responses_count' => ['surveys.responses_count']
    },
    :search_array => ['surveys.project_name', 'surveys.code']


  before_filter :load_users, :only => [:new, :create, :edit, :update]
  def index
    get_sorted_objects(params)
  end
  
  def new
    @emote = Survey.new
  end
  
  def create
    @emote = Survey.new params[:emote]
    @emote.force_creation = true
    if @emote.save
      flash[:notice] = "Emote successfully created"
      redirect_to admin_emotes_path
    else
      flash[:alert] = 'Error creating emote'
      render :action => 'new'
    end
  end
  
  def edit
    @emote = Survey.find params[:id]
  end
  
  def update
    @emote = Survey.find params[:id]
    if @emote.update_attributes params[:emote]
      flash[:notice] = "Emote successfully saved"
      redirect_to admin_emotes_path
    else
      flash[:alert] = 'Error saving emote'
      render :action => 'edit'
    end
  end

  def destroy
    @emote = Survey.find params[:id]
    if @emote.destroy
      flash[:notice] = "Emote successfully deleted"
      redirect_to admin_emotes_path
    else
      flash[:alert] = 'Error deleting emote'
      render :action => 'edit'
    end
  end
  
  def scorecard
    @survey = Survey.find params[:id]
    @survey.generate_action_token!
    @survey.save!
    render :template => 'surveys/scorecard'
  end
  
  protected
    def load_users
      @users = User.all.sort_by(&:email)
    end
end
