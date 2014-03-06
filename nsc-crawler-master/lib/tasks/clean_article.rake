# encoding: UTF-8

desc "clean article"
task :clean_article => :environment do
	Article.all.each do |article|
		article.content = article.content.gsub("\n", '').gsub("\r", '').gsub("\t", '')
		article.save
	end
end