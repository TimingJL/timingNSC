# encoding: UTF-8

desc "google search test"
task :google_search_test => :environment do
	
	time = Time.parse('2009-06-01')
	end_time = Time.now
	text_dir_path = Rails.root.to_s
	File.open(text_dir_path + '/' + 'google_search_result.txt', 'w+') { |f|
	 	while time <= end_time do
			Google::Search::Web.new(:query => "site:http://news.cnyes.com/Content/#{time.strftime("%Y%m%d")}").each do |result|
				f.puts(result.uri)
			end
			time += 1.day
		end
	}
end