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

  def refresh_counters
    refresh_response_counters
    redirect_to :action => :index
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
    @survey = Survey.find(params[:id])
    redirect_to root_path if @survey.nil?

    respond_to do |format|
      format.html do
        @survey.generate_action_token!
        @survey.scorecard_viewed_at = DateTime.now
        @survey.save!
        render 'surveys/scorecard'
      end
      format.xls do
        report = ScorecardDataXls.new
        report.survey = @survey
        send_data report.generate, :content_type => Mime::XLS, :filename => "scorecard_#{@survey.code.downcase}_#{DateTime.now.strftime('%Y%m%d%H%M')}.xls"
      end
    end
  end
  
protected
  def load_users
    @users = User.all.sort_by(&:email)
  end

  def refresh_response_counters
    begin
      Survey.connection.execute <<-SQL
        UPDATE
          surveys,
          (SELECT COUNT(*) AS responses_count, s.id AS emote_id
           FROM surveys AS s INNER JOIN survey_result AS sr ON s.code = sr.code
           WHERE sr.is_removed = 0 GROUP BY s.code) AS surveys_responses
        SET surveys.responses_count = surveys_responses.responses_count
        WHERE surveys.id = surveys_responses.emote_id;
      SQL
      flash[:notice] = 'Counters refreshed successfully'
    rescue => e
      flash[:alert] = e.message
    end
  end

end
