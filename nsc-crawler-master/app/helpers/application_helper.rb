module ApplicationHelper
  def flash_info(content_or_options_with_block = nil)
    raw(%Q|<div class="alert alert-info">|+content_or_options_with_block.to_s+%Q|</div>|)
  end

  def article_entry(article)
  	%Q|<a href="#{article_read_path :id => article.id}">#{article.title}</a> <a href="#{article.url}" target="_blank" class="btn"><i class="icon-tag"></i></a>|.html_safe
  end

  def menu_active?(options={})
    if options[:controller] and options[:action]
      params[:controller].to_s == options[:controller].to_s and params[:action].to_s == options[:action].to_s ? 'active' : ''
    elsif options[:controller]
      params[:controller].to_s == options[:controller].to_s ? 'active' : ''
    else
      'active'
    end
  end
end
