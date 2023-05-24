require "csv"

task :import_users => :environment do
  csv_file = Rails.root.join('public', 'users - Sheet1.csv')


  CSV.foreach(csv_file, headers: true) do |row|
    User.create(row.to_h)
  end

  puts "CSV import completed."
end
