class FrontendNotifierGenerator < Rails::Generators::Base

  source_root File.expand_path("../../../../app", __FILE__)
  desc 'Copies frontend_notifier views and stylesheets to your application.'

  def generate_views_and_styles
    copy_file "assets/stylesheets/_frontend_notifier.css.scss", "app/assets/stylesheets/_frontend_notifier.css.scss"
    copy_file "views/shared/_frontend_notifier.html.haml", "app/views/shared/_frontend_notifier.html.haml"
  end

end