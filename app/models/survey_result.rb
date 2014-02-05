class SurveyResult < ActiveRecord::Base

  belongs_to :survey, :foreign_key => :code, :primary_key => :code

  EMOTIONS = {
      'enthusiastic' => :positive,
      'elated' => :positive,
      'excited' => :positive,
      'thrilled' => :positive,
      'amazed' => :positive,
      'happy' => :positive,
      'satisfied' => :positive,
      'surprised' => :positive,
      'content' => :positive,
      'delighted' => :positive,
      'outraged' => :negative,
      'angry' => :negative,
      'unhappy' => :negative,
      'frustrated' => :negative,
      'irritated' => :negative,
      'humiliated' => :negative,
      'disgusted' => :negative,
      'miserable' => :negative,
      'dissatisfied' => :negative,
      'uneasy' => :negative
  }

  BAROMETER_MAP = { # elena 3-2013: changing intensity labels: it's ok, love it, hate it
                    :mn => {:name => 'It\'s OK', :intensity => (0...34)}, # Is positive or negative, intensity is bottom third
                    :mp => {:name => 'It\'s OK', :intensity => (34...66)}, # Is positive or negative, intensity is middle third
                    :pn => {:name => 'Hate it!', :intensity => (66..1000), :emotion_type => :negative}, # Is negative and intensity is >= 66
                    :pp => {:name => 'Love it!', :intensity => (66..1000), :emotion_type => :positive} # Is positive and intensity is >= 66
  }


  def self.positives
    EMOTIONS.select {|k,v| v == :positive }.map {|k,v| k}
  end

  def self.negatives
    EMOTIONS.select {|k,v| v == :negative }.map {|k,v| k}
  end

  def self.barometer_category_from_intensity(emotion, intensity, return_name = false)
    BAROMETER_MAP.each do |code, cfg|
      if (cfg[:intensity] === intensity) && (cfg[:emotion_type].nil? ? true : cfg[:emotion_type]==EMOTIONS[emotion.to_s])
        return return_name ? cfg[:name] : code
      end
    end
    nil
  end


  def self.sql_condition(*args)
    sanitize_sql(*args)
  end

  def id
    read_attribute(:survey_result_id)
  end

  def id=(id)
    write_attribute(:survey_result_id, id)
  end

  #TODO Move emails from a separate table to the SurveyResult model
  def email
    if mail = read_attribute(:email)
      mail
    else
      ext_email = self.class.connection.select_value("SELECT `email` FROM `survey_user_data` WHERE `survey_result_id` = #{self.id}")
      write_attribute(:email, ext_email)
      ext_email
    end
  end

end