# encoding: UTF-8

class ExportMailer < ActionMailer::Base
  default from: "nccu.cs.ttsai.lab@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.export_mailer.inform.subject
  #
  def inform(option=nil)
    @name = option[:name]
    @file_link = option[:file_link]

    @category_name = option[:category_name]
    @category_type_name = ''
    case option[:category_type]
    when 'Keyword'
      @category_type_name = '關鍵字'
    when 'Macrolevel'
      @category_type_name = '宏觀'
    else
      @category_type_name = '全部'
    end

    mail to: option[:email], subject: "[創新行動商務科技之跨領域整合型研究計劃] 新聞資料索取通知"
  end
end
