class ApplicationController < ActionController::Base
 around_action :switch_locale
 
 
 def default_url_options
   { locale: I18n.locale }
 end

 private

 def switch_locale(&block)
   locale = params[:locale] || locale = cookies[:locale] || I18n.default_locale
   I18n.with_locale(locale, &block)
   cookies[:locale] = locale
 end
end
