namespace :db_data do

  desc "Copies `surveys` MySQL table to Mongo collection"
  task :surveys_to_mongo => :environment do
    surveys = ActiveRecord::Base.connection.select_all "SELECT * FROM `surveys`"
    surveys.each do |ar_survey|
      survey = Survey.new
      ar_survey.each do |attr, val|
        next if attr=='id'
        survey.send("#{attr}=", val)
      end
      if survey.save
        puts "Survey #{survey.project_name} copied"
      else  
        puts "Error copying #{survey.project_name}"
      end
    end
    puts "\n\nDone"
  end


end