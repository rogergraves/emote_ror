namespace :dev_test do

  desc "Lists all users"
  task :userlist => :environment do
    ROW_FORMAT = ' %-5s  %-20s  %-30s'

    puts ROW_FORMAT % ['ID', 'Email', 'Full name']
    puts '-----------------------------------------------'
    User.all.each do |user|
      puts ROW_FORMAT % [user.id.to_s, user.email, user.full_name]
    end
    puts "\n\nDone"
  end

  desc "Deletes specified user and all connected data"
  task :vanish_user, :user_id, :needs => :environment do |t, args|
    throw "ERROR: user_id not supplied!" if args.user_id.nil?
    users = User.find(args.user_id.split(/;/)) || raise("User(s) not found")
    users = [users] unless users.is_a?(Array)
    users.each do |user|
      puts "Deleting #{user.email}..."
      user.destroy
    end
    puts "\nDone"
  end

  desc "Adds products of all types to a specified user"
  task :add_all_products, :user_id, :needs => :environment do |t, args|
    throw "ERROR: user_id not supplied!" if args.user_id.nil?
    user = User.find(args.user_id) || raise("User not found")
    username = user.full_name.blank? ? user.email : user.email

    Subscription::OPTIONS.each do |subscr_type|
      puts "Adding '#{subscr_type[:name]}'..."
      subscription = Subscription.new(:start_date => DateTime.now, :user_id => user.id)
      subscription.emote_amount = subscr_type[:amount]
      subscription.trial = false #Auto sets duration
      transaction = PaypalTransaction.new
      transaction.user = user
      transaction.subscription = subscription
      transaction.token = 'TEST-PURCHASE'
      transaction.date = Time.now
      transaction.currency = Country.find_by_country_code(user.country_code || 'US')[:currency]
      transaction.total = subscr_type[:price]
      transaction.customer_name = username
      transaction.customer_id = 0
      transaction.customer_address = "#{username}'s address here"
      transaction.customer_email = user.email
      transaction.customer_phone = "#{username}'s phone"
      transaction.description = subscr_type[:name]
      transaction.product_code = subscr_type[:prod_code]
      subscription.save
      transaction.save
    end
    puts "Done"
  end


end