module CicholBlog
  class App < Padrino::Application
    register ScssInitializer
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    ##
    # Caching support.
    #
    register Padrino::Cache
    enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

=begin

    get :generate, :map => '/generate' do
      account = Account.find_by(id: session[:account_id]) unless session[:account_id].nil?
      if account && account.role == 'admin'
        path = File.expand_path('../../app/html', __FILE__)
        Article.all.each do |a|
          @title = a.title
          @article = a
          FileUtils.mkpath("#{path}/article/#{a.id}")
          File.open("#{path}/article/#{a.id}/index.html", 'wb'){ |f| f.write(render('article/show'))}
        end

        Category.all.each do |c|
          @title = c.name
          @articles = c.articles.order('id DESC').all
          FileUtils.mkpath("#{path}/category/#{c.id}")
          File.open("#{path}/category/#{c.id}/index.html", 'wb'){ |f| f.write(render('category/list'))}
        end
        
        @title = "Mabinogion"
        @articles = Article.order('id DESC').all
        File.open("#{path}/index.html", 'wb'){ |f| f.write(render('category/list'))}
        'ok'
      end
    end
    
=end

    error 404 do
      render 'error/404', :layout => 'application'
    end

  end
end
