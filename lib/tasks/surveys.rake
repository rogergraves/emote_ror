namespace :surveys do

  desc "Recreates QR code images for all surveys"
  task :recreate_qr_codes => :environment do
    qr_dir = File.join(Rails.root, 'public', 'images', 'qr')
    Dir.mkdir(qr_dir) unless File.exists?(qr_dir) && File.directory?(qr_dir)

    Survey.all.each do |survey|
      puts "Generating for #{survey.code}..."
      survey.make_qrcode!
    end
    puts "\nDone"
  end

end