# encoding: UTF-8

class MainController < ApplicationController
	def index
		# INDEX
	end

	def grab_by_keyword
		if params[:option] && !params[:option][:keyword].empty? && !params[:option][:grab_mode].empty?
			@keyword = Keyword.find_by_name(params[:option][:keyword])
		    if !@keyword
		      @keyword = Keyword.new(:name => params[:option][:keyword])
		      @keyword.save
		    end
		    @keyword.update_attributes!(lock: true)

		    task = LongTasks.new
			task.delay.grab_by_keyword(params[:option])
		end
		redirect_to category_wait_path(category_type: 'Keyword', category_id: @keyword.id)
	end

	def grab_all_macrolevel
		if params[:grab_mode]
			task_array = []
		    Macrolevel.all.each do |macrolevel|
		      new_task = LongTasks.new
		      task_array.push new_task
		      new_task.delay.grab_by_macrolevel({id: macrolevel.id, grab_mode: params[:grab_mode]})
		    end
			redirect_to macrolevel_control_path
		end
	end

	def grab_by_macrolevel
		if params[:id] && params[:grab_mode]
			Macrolevel.find(params[:id]).update_attributes!(lock: true)

			task = LongTasks.new
			task.delay.grab_by_macrolevel({id: params[:id], grab_mode: params[:grab_mode]})

			if params[:request_type] == 'ajax'
				render json: { status: 'ok' }
			else
				redirect_to category_wait_path(category_type: 'Macrolevel', category_id: params[:id])
			end
		end
		
	end

	def category_list
		@category = get_category(params[:category_type], params[:category_id])
		@articles = []
		if !@category.lock
			@articles = @category.articles.order('authorize_at DESC').paginate(:page => params[:page], :per_page => 10)
		else
			redirect_to category_wait_path(category_type: params[:category_type], category_id: params[:category_id])
		end
	end

	def category_wait
		flash[:notice] = '背景工作正在執行，請耐心等待數分鐘...'
		@category = get_category(params[:category_type], params[:category_id])
	end

	def category_wait_query
		category = get_category(params[:category_type], params[:category_id])
		render :json => { :type => category.class.name,
						  :id   => category.id, 
			              :lock => category.lock }
	end

	def category_task_log
		@category = get_category(params[:category_type], params[:category_id])
		@category.task_logs.each do |task_log|
			if task_log.duration == nil
				task_log.duration = 'task failed'
				task_log.save
			end
		end
		render layout: false
	end

	def category_destroy
		category = get_category(params[:category_type], params[:category_id])
		category.destroy

		case params[:category_type]
		when 'Keyword'
			redirect_to keyword_control_path
		when 'Macrolevel'	
			redirect_to macrolevel_control_path
		end
	end

	def keyword_control
		@keywords = Keyword.all
	end

	def kmw_control
		@articles_count = Kmw.first.articles.count
		@fail_kmw_prelink_list = KmwPrelink.where("success = ?", false)
	end

	def macrolevel_control
		@macrolevels = Macrolevel.all

		@has_lock = false
		@article_count = 0
		@macrolevels.each do |macrolevel|
			if macrolevel.lock && !@has_lock
				@has_lock = true
			end
			@article_count += macrolevel.articles.count
		end
	end

	def article_read
		@article = Article.find(params[:id])
	    respond_to do |format|
	      format.html # html.erb
	      format.json { render json: @article }
	    end
	end

	def import_kmw
		data = JSON.parse(params[:data])

		task = LongTasks.new
		task.delay.grab_kmw(data['prelinks'])

		render text: data['prelinks'].count
	end

	private

	def get_category(type, id)
		case type
		when 'Kmw'
			Kmw.find(id)
		when 'Keyword'
			Keyword.find(id)
		when 'Macrolevel'	
			Macrolevel.find(id)		
		end
	end
end
