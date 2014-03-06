# encoding: UTF-8

desc "google link test"
task :google_link_test => :environment do
	text_dir_path = Rails.root.to_s
	File.open(text_dir_path + '/' + 'google_search_result.txt', 'r').each_line do |line|
		date_string = /\d{8}/.match(line).to_s
		puts Date.parse(date_string)
	end
end