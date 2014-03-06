class LongTasks
  def grab_by_keyword(option=nil)

    a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'} 

    # get input  
    input = option[:keyword]
    
    grab_mode = option[:grab_mode]
    articles_count = 0
    article_repeat = false
    max_page = 1000
    start_time = Time.now
    
    keyword = Keyword.find_by_name(input)
    keyword.update_attributes(:lock => true)

    # translate  
    final = URI::escape("http://news.cnyes.com/search.aspx?q=#{input}&D=8&P=")

    task_log = TaskLog.new
    task_log.category = keyword
    task_log.save

    # Traversal page
    for i in 1..max_page

      articles_count = 0
      # Get address
      a.get(final+i.to_s+'&1=1') do |page|
        doc = Nokogiri::HTML(page.body)

        article_title = ''
        relative_address = ''

        doc.xpath('.//ul').each do |ul|
          if ul['class'] && ul['class'].index('list_1') && ul['class'].index('bd_dbottom')
            ul.xpath('.//a').each do |a|
              if a['target'] && a['target'].index('_blank')
                article_title = a.inner_text
                relative_address = a['href']
                absolute_address = "http://news.cnyes.com#{relative_address}"

                # Get Article
                article_repeat = save_article(absolute_address, keyword)
                articles_count = articles_count + 1
              end
            end
          end
        end
      end

      if terminate_check(keyword, grab_mode, articles_count, article_repeat)
        end_time = Time.now
        task_log.duration = (end_time - start_time).to_s
        task_log.save
        return
      end
    end
  rescue
    keyword = Keyword.find_by_name(option[:keyword])
    keyword.lock = false
    keyword.save
    
    task_log = keyword.task_logs.find_by_duration(nil)
    task_log.duration = 'task failed'
    task_log.save
  end

  def grab_by_macrolevel(option=nil)
    a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'} 

    grab_mode = option[:grab_mode]
    articles_count = 0
    article_repeat = false
    max_page = 1000
    start_time = Time.now

    macrolevel = Macrolevel.find(option[:id])
    macrolevel.update_attributes(:lock => true)

    timestart = '20100101'                                                   
    timeend = Time.now.strftime("%Y%m%d").to_s
    
    # translate  
    final = URI::escape("http://news.cnyes.com/#{macrolevel.tag}/sonews_#{timestart}#{timeend}_")

    task_log = TaskLog.new
    task_log.category = macrolevel
    task_log.save

    # Traversal page
    for i in 1..max_page

      articles_count = 0
      # Get address
      a.get(final+i.to_s+'.htm') do |page|
        doc = Nokogiri::HTML(page.body)

        article_title = ''
        relative_address = ''

        doc.xpath('.//ul').each do |ul|
          if ul['class'] && ul['class'].index('list_1') && ul['class'].index('bd_dbottom')
            ul.xpath('.//a').each do |a|
              if a['href'].index('Content')
                article_title = a.inner_text
                relative_address = a['href']
                absolute_address = "http://news.cnyes.com#{relative_address}"

                # Get Article
                article_repeat = save_article(absolute_address, macrolevel)
                articles_count = articles_count + 1
              end
            end
          end
        end
      end

      if terminate_check(macrolevel, grab_mode, articles_count, article_repeat)
        end_time = Time.now
        task_log.duration = (end_time - start_time).to_s
        task_log.save
        return
      end
    end
  rescue
    macrolevel = Macrolevel.find(option[:id])
    macrolevel.lock = false
    macrolevel.save

    task_log = macrolevel.task_logs.find_by_duration(nil)
    task_log.duration = 'task failed'
    task_log.save
  end

  def grab_by_google
    if GoogleDate.count == 0
      begin_date = Date.parse('20090601')
      end_date   = Date.parse('20131217')

      while begin_date <= end_date do
        GoogleDate.create(:indexed_at => begin_date)
        begin_date += 1.day
      end
    end

    text_dir_path = Rails.root.to_s
    File.open(text_dir_path + '/' + 'google_search_result.txt', 'r').each_line do |line|
      date_string = /\d{8}/.match(line).to_s
      date = Date.parse(date_string)
      google_date = GoogleDate.find_by_indexed_at(date)

      save_article(line, google_date)
      puts line
    end
  end

  private

  def terminate_check(category, grab_mode, articles_count, article_repeat)
    # Terminate task
    case grab_mode
    when 'UPDATE'
      if article_repeat || articles_count == 0
        category.lock = false
        category.save
        return true
      end
    when 'ALL'
      if articles_count == 0
        category.lock = false
        category.save
        return true
      end
    else
    end
    return false   
  end
  
  def save_article(absolute_address, category)
    article = Article.find_by_url(absolute_address)
    # Found Article in model
    if article
      # Check whether Article in category list
      if !category.articles.include? article
        category.articles.push(article)
        return false
      else
        return true
      end
    end

    title = ''
    content = ''
    authorize_at_string = ''
    authorize_at = nil

    b = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'}

    b.get(absolute_address) do |page|
      article_doc = Nokogiri::HTML(page.body)

      article_doc.xpath('.//title').each do |t|
        title = t.inner_text
      end

      article_doc.xpath('.//span').each do |span|
        if span['class'] == 'info'
          authorize_at_string = /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/.match(span.inner_text).to_s
          authorize_at = DateTime.parse(authorize_at_string).change(:offset => "+0800")
        end
      end
    
      article_doc.xpath('.//div').each do |div|
        if div['id'] == 'newsText'
          content = div.inner_text.gsub("\n", '').gsub("\r", '').gsub("\t", '')
        end  
      end 
    end             

    article = Article.find_by_title(title)
    # Found Article in model
    if article
      # Check whether Article in category list
      if !category.articles.include? article
        category.articles.push(article)
        return false
      else
        return true
      end
    end

    # Save Article in model
    article = Article.new(:title => title,
                          :content => content,
                          :authorize_at_string => authorize_at_string,
                          :authorize_at => authorize_at,
                          :url => absolute_address,
                          :source => 'cnyes.com')
    if article.valid? && article.save
      category.articles.push(article)
    end

    return false
  rescue
    return false
  end


#== KMW

  def grab_kmw(prelinks)
     
    category = Kmw.first
    a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'} 

    # translate  
    root = URI::escape("http://kmw.ctgin.com/")
    
    a.get(root) do |page|
      doc = Nokogiri::HTML(page.body)
      doc.xpath('.//a').each do |link|
        if link[:style] == 'COLOR: #0055ca'
          a.get(link[:href]) do |check_page|
            prelinks.each do |prelink|

              kmw_prelink = KmwPrelink.find_by_url(prelink)
              if !kmw_prelink
              
              kmw_prelink = KmwPrelink.new(:url => prelink, :success => false)
              kmw_prelink.save
              
              begin
                a.get(prelink) do |article_page|
                  fixed_content = article_page.body.force_encoding('big5').encode('UTF-8', :invalid => :replace, :undef => :replace)
                  article = Nokogiri::HTML(fixed_content)
                  
                  title = ''
                  content = ''
                  authorize_at_string = ''
                  authorize_at = ''
                  absolute_address = prelink

                  article.xpath('.//td').each do |td|
                    if td[:id] == 'newsTitle'
                      title = td.inner_text
                    end
                  end

                  article.xpath('.//input').each do |input|
                    if input[:name] == 'note_date'
                      authorize_at_string = input[:value]
                      authorize_at = DateTime.parse(authorize_at_string).change(:offset => "+0800")
                    end
                  end

                  article.xpath('.//td').each do |td|
                    if td[:class] == 'a15gray'
                      content = td.inner_text.gsub("\n", '').gsub("\r", '').gsub("\t", '')
                    end
                  end

                  article = Article.find_by_title(title)
                  if !article
                    # Save Article in model
                    article = Article.new(:title => title,
                                          :content => content,
                                          :authorize_at_string => authorize_at_string,
                                          :authorize_at => authorize_at,
                                          :url => absolute_address,
                                          :source => 'kmw.ctgin.com')
                    if article.valid? && article.save
                      kmw_prelink.success = true
                      kmw_prelink.save
                      category.articles.push(article)
                    else
                      kmw_prelink.success = false
                      kmw_prelink.save
                    end
                  end
                end
              rescue
                kmw_prelink.success = false
                kmw_prelink.save
              end

              end
            end
          end
        end
      end
    end
  end
end
