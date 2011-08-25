class RegeneratePublicScorecardCodes < ActiveRecord::Migration
  def self.up
    Survey.all.each do |survey|
      survey.generate_code!('scorecard_code')
      survey.save!
    end
  end

  def self.down
  end
end
