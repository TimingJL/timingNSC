class ExportController < ApplicationController
	def index
		#
	end

	def category
		exporter = ArticleExporter.new

		exporter.delay.export_category(params[:export_log])
		redirect_to export_success_path	
	end

	def keyword
		exporter = ArticleExporter.new

		exporter.delay.export_by_keywords(params[:export_log_keyword])
		redirect_to export_success_path	
	end

	def all
		exporter = ArticleExporter.new

		exporter.delay.export_all(params[:export_log])
		redirect_to export_success_path
	end

	def success
		#
	end
end
