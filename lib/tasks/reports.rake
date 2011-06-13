namespace :reports do

  desc "Sends emote activity reports if needed (according to user's prefs)"
  task :send_emote_activity => :environment do
    User.all.each do |user|
      today = Date.today
      send_it = case user.activity_report_interval
        when 'daily' then true #Considering raketask is launched daily at midnight
        when 'weekly' then today.wday == 1 #Sunday night at midnight == Monday
        when 'monthly' then today.day == 1 #00:01 or 1:01am on first of month
        else false
      end
      
      next if user.surveys.empty? || user.activity_report_interval == 'none' || !send_it
      ReportMailer.deliver_emote_activity(user)
      puts "Sent for #{user.email}"
    end
  end

end