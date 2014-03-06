require 'rubygems'
require 'zip'

class ArticleExporter
	def export_category(option=nil)
		categoty = get_category(option[:category_type], option[:category_id])
		articles = categoty.articles
		zipname = generate_files(articles)
		
		option[:file_path] = ROOT_URL + '/resource/file/zip/' + zipname
		option[:request_type] = 'Category'
		ExportLog.create(option)

		option[:file_link] = ROOT_URL + '/resource/file/zip/' + zipname
		option[:category_name] = categoty.name

		ExportMailer.inform(option).deliver
	end

	def export_by_keywords(option=nil)
		count = Article.count
		articles = Article.search {
			fulltext option[:keyword]
			with(:source).equal_to(option[:source])
			paginate :page => 1, :per_page => count
		}.results
		zipname = generate_files(articles)
		
		option[:file_path] = ROOT_URL + '/resource/file/zip/' + zipname
		option[:request_type] = 'Category'
		#ExportLog.create(option)

		option[:file_link] = ROOT_URL + '/resource/file/zip/' + zipname
		option[:category_name] = "#{option[:keyword]} / #{option[:source]}"

		ExportMailer.inform(option).deliver
	end

	def export_all(option=nil)
		articles = Article.all
		zipname = generate_files(articles)
		
		option[:file_path] = ROOT_URL + '/resource/file/zip/' + zipname
		option[:request_type] = 'All'
		ExportLog.create(option)

		option[:category_type] = 'All'
		option[:file_link] = ROOT_URL + '/resource/file/zip/' + zipname

		ExportMailer.inform(option).deliver
	end

	private

	def generate_files(articles)
		text_dir_path = Rails.root.join('public', 'resource', 'file', 'text').to_s
		zip_dir_path  = Rails.root.join('public', 'resource', 'file', 'zip').to_s
		
		puts(text_dir_path)

		fileset = []
		articles.each do |article|
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
		FileUtils.chmod 0755, zip_dir_path + '/' + zipname, :verbose => true

		return zipname
	end

	def get_filename(article)
		"[#{article.authorize_at}]#{article.title}".gsub(' ', '').gsub('/', '-')[0..100] + '.txt'
	end

	def get_filecontext(article)
		%Q|#{article.title}\n#{article.url}\n#{article.authorize_at}\n#{article.content.gsub("\t",'').gsub("\n",'')}|
	end

	def get_category(type, id)
		case type
		when 'Keyword'
			Keyword.find(id)
		when 'Macrolevel'	
			Macrolevel.find(id)		
		end
	end
end