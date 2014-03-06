# encoding: UTF-8

desc "kmw_news crawler"
task :kmw_news => :environment do

	init_page = ENV['init_page'] || 1
	end_page  = ENV['end_page']

	# 生成 Browser instance
	while(init_page != end_page)
		begin
		  browser = Watir::Browser.new :chrome
		  init_page = action_entity(browser, init_page, end_page)
		  browser.close
		rescue
		  puts "Browser dead...> <"
		end
	end
end

def action_entity(browser, init_page, end_page)

current_page = init_page
begin
	#input  設定時間
	time_start = "2000/1/1"
	time_end   = "2014/1/7"

	# 進入知識贏家網頁並從學校授權按鈕點擊登入
	browser.goto 'http://kmw.ctgin.com'
	browser.a(:style => 'COLOR: #0055ca').click
	sleep 3

	# 進入台灣新聞區 ->新聞檢索
	browser.td(:id => 'Menu1-menuItem001').click
	browser.td(:id => 'Menu1-menuItem001-subMenu-menuItem001').click
	sleep 3

	# 點選台灣地區
	browser.frame(:id => 'if1').frame(:name => 'fLeft').td(:id => 'tabA').click
	browser.frame(:id => 'if1').frame(:name => 'fLeft').frame(:id => 'if39').div(:id => 'i14603').span.click
	browser.frame(:id => 'if1').frame(:name => 'fLeft').frame(:id => 'if39').div(:id => 'i14610').span.click
	browser.frame(:id => 'if1').frame(:name => 'fLeft').frame(:id => 'if39').div(:id => 'i14636').link.click
	sleep 3
	
	# 控制時間 
 	browser.frame(:id => 'if1').frame(:name => 'fTop').text_field(:id => 'txtDateFrom').set time_start
 	browser.frame(:id => 'if1').frame(:name => 'fTop').text_field(:id => 'txtDateTo').set time_end

	# 點選查詢
	browser.frame(:id => 'if1').frame(:name => 'fTop').input(:type => 'image', :name => 'image').click
	sleep 5 

	# 跳到頁面
	browser.frame(:id => 'if1').frame(:name => 'fCenter').frame(:id => 'if1').text_field(:id => 'txtPage').set init_page
	browser.send_keys :enter
	sleep 5
	
	#先記錄網址
	href_array={}  	#用來放置網址
	href_count=1 	#網址數量	
	time_array={}	#存放頁數
	time_array[0]=0 #當今頁數
	time_array[1]=1 #總頁數

	text_dir_path = Rails.root.to_s
	File.open(text_dir_path + '/' + 'kmw_result.txt', 'w+') do |f|
		until time_array[0] == (time_array[1] || end_page) do #直到最後一頁
			prelinks = []

			#抓取頁數
			browser.frame(:id => 'if1').frame(:name => 'fCenter').frame(:id => 'if1').table(:border => '0').fonts.each do |font|
				if font.color == '#FF0000'	
					time_array = font.text.split("/")  #EX: 1/24
					current_page = time_array[0]
					puts "page #{time_array[0]}"
					f.puts("!![#{time_array[0]}]")
				end
			end

			#記錄網址
			browser.frame(:id => 'if1').frame(:name => 'fCenter').frame(:id => 'if1').as.each do |a|
				if a.target == 'new'
					href_array[href_count] = a.href  #把網址放入陣列 從1開始
					href_count = href_count + 1
					# puts a.href
					f.puts(a.href)
					prelinks.push a.href
				end
			end
			
			#uri = URI.parse('http://localhost:3000/import/kmw')
			uri = URI.parse('http://nccu.twbbs.org/import/kmw')

			response = Net::HTTP.post_form(uri, {"data" => {'prelinks' => prelinks}.to_json })
			puts "server recieved links: #{response.body}"

			#點擊下一頁
			browser.frame(:id => 'if1').frame(:name => 'fCenter').frame(:id => 'if1').a(:id => 'btnPgNext1').click	
			sleep 3
		end
	end
	return current_page
rescue
	return current_page
end
end