# encoding: UTF-8
desc "zip generator test"
task :zip_generator_test => :environment do
	text_dir_path = Rails.root.join('public', 'resource', 'file', 'text').to_s
	zip_dir_path  = Rails.root.join('public', 'resource', 'file', 'zip').to_s
	
	puts(text_dir_path)

	fileset = []
	@articles = Article.all
	@articles.each do |article|
		filename = get_filename(article)
		filenpath = text_dir_path + '/' + filename
		if !File.exist?(filenpath)
			File.open(filenpath, 'w+') {|f| f.write(get_filecontext(article))}
		end
		fileset.push(filename)
	end

	zipname = Digest::MD5.hexdigest(Time.now.to_s) + '.zip'
	Zip::File.open(zip_dir_path + '/' + zipname, Zip::File::CREATE) do |zipfile|
		fileset.each do |filename|
			zipfile.add(filename, text_dir_path + '/' + filename)
		end
	end
end


def get_filename(article)
	"[#{article.authorize_at}]#{article.title}.txt".gsub(' ', '').gsub('/', '-')
end

def get_filecontext(article)
	%Q|#{article.title}\n#{article.url}\n#{article.authorize_at}\n#{article.content.gsub("\t",'').gsub("\n",'')}|
end