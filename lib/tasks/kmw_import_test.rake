# encoding: UTF-8

desc "kmw import test"
task :kmw_import_test => :environment do
    prelinks = [
'http://kmw.ctgin.com/member/news_search2/se_content_file8.asp?query=&src=B&date=20140107&file=N0613.001&dir=B&area=tw&frompage=se',
'http://kmw.ctgin.com/member/news_search2/se_content_file8.asp?query=&src=B&date=20140107&file=N0611.001&dir=B&area=tw&frompage=se',
'http://kmw.ctgin.com/member/news_search2/se_content_file8.asp?query=&src=B&date=20140107&file=N0609.001&dir=B&area=tw&frompage=se',
'http://kmw.ctgin.com/member/news_search2/se_content_file8.asp?query=&src=B&date=20140107&file=N0608.001&dir=B&area=tw&frompage=se',
'http://kmw.ctgin.com/member/news_search2/se_content_file8.asp?query=&src=B&date=20140107&file=N0607.001&dir=B&area=tw&frompage=se']
    
    category = Kms.first
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

              kms_prelink = KmsPrelink.find_by_url(prelink)
              if !kms_prelink
              
              kms_prelink = KmsPrelink.new(:url => prelink, :success => false)
              kms_prelink.save
              
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
                      content = td.inner_text
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
                      kms_prelink.success = true
                      kms_prelink.save
                      category.articles.push(article)
                    else
                      kms_prelink.success = false
                      kms_prelink.save
                    end
                  end
                end
              rescue
                kms_prelink.success = false
                kms_prelink.save
              end

              end
            end
          end
        end
      end
    end
end