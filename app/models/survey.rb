# == Schema Information
# Schema version: 20110123204321
#
# Table name: surveys
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  project_name    :string(255)     not null
#  score           :float           default(0.0)
#  responses_count :integer(4)      default(0)
#  active          :boolean(1)      default(FALSE)
#  public          :boolean(1)      default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  code            :string(20)      not null
#  action_token    :string(255)
#

class Survey < ActiveRecord::Base
  require 'zlib'
  
  belongs_to :user
  
  has_many :survey_results, :foreign_key => :code, :primary_key => :code
  
  validates :user, :presence => true
  validates :project_name, :presence => true, :uniqueness => {:scope => :user_id}
  validates :code, :presence => true, :uniqueness => true

  alias_attribute :public_scorecard, :public 
  alias_attribute :short_stimulus, :project_name
  attr_accessible :project_name, :public, :active
  
  after_save do
    survey_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <survey status='#{ (self.active?) ? 'on' : 'off' }'>
    <stimulus short=\"#{self.project_name}\"><![CDATA[Consider every aspect of your most recent experience with <span class=\"bold-text\">#{self.project_name}</span>.
    What was that like for you? How would you describe your feelings about this experience to someone else?]]></stimulus>
      <thanks>Thank you for e.moting!</thanks>
    </survey>"
    File.open("#{SURVEY_STORAGE_PATH}#{self.code}.xml", 'w') {|f| f.write(survey_xml) }
  end
  
  before_destroy do
    begin
      File.delete("#{SURVEY_STORAGE_PATH}#{self.code}.xml")
    rescue
      #TODO i'm sleeping, need to add something here later
    end
  end
  
  before_validation(:on => :create) do
    generate_survey_code!
  end

  validate(:on => :create) do |survey|
    unless survey.user(true).can_add_scorecard?
      survey.errors[:user] = ' cannot add more emotes'
    end
  end

  def emote_direct_link
    "http://emotethis.com/index.php?uid=#{self.code}" # http://www.emotethis.com/browser/index.php?survey=#{self.code}
  end

  def scorecard_embed_link
    "<iframe src='#{emote_direct_link}'/>" #Approx.
  end

protected

  def generate_survey_code!
    self.code = Zlib::crc32("#{self.user ? self.user.full_name : 'no_user'}-#{self.user_id}--#{self.id}-#{self.project_name}-=-[OMATORE]-=-#{Time.now.to_i}").to_s(36).upcase
  end

end
