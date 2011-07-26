namespace :admin do

  desc "Create a new admin user"
  task :create, [:email, :password] => :environment do |t, args|
    throw "ERROR: Incorrect arguments! Usage: $ rake admin:create['lord@domain.com','password']" if args.email.nil? || args.password.nil?
    admin = Admin.new do |a|
      a.email = args.email
      a.password = a.password_confirmation = args.password
    end
    if admin.save
      puts "Admin #{admin.email} created"
    end
    puts "\nDone"
  end

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
  task :vanish_user, [:user_id] => :environment do |t, args|
    throw "ERROR: user_id not supplied!" if args.user_id.nil?
    users = User.find(args.user_id.split(/;/)) || raise("User(s) not found")
    users = [users] unless users.is_a?(Array)
    users.each do |user|
      puts "Deleting #{user.email}..."
      user.destroy
    end
    puts "\nDone"
  end

end