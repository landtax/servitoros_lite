module ApplicationHelper

  def bootstrap_class_for flash_type
      case flash_type
        when :success
          "alert-success"
        when :error
          "alert-error"
        when :alert
          "alert-block"
        when :notice
          "alert-info"
        else
          flash_type.to_s
      end
  end

  def clippy(text, bgcolor='#FFFFFF')
    relative_path = ENV['RAILS_RELATIVE_URL_ROOT']
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="#{relative_path}/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="#{relative_path}/flash/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
    html.html_safe
  end

  def prefix_subdir(path)
      File.join PREFIX_SUBDIR, path
  end

  def lang_selector
    select_tag :language, options_for_select(I18n.available_locales.to_a.map{ |locale| [t('name', :locale => locale), locale] }, I18n.locale.to_sym) 
  end

  def hidden_if condition
    " hidden " if condition
  end


end
