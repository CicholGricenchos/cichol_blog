# Helper methods defined here can be accessed in any controller or view in the application

module CicholBlog
  class App
    module GeneralHelper
      def error_404_jsonp
        hash = {
          title: "404",
          body: render('error/404', layout: false)
        }
        "show(#{hash.to_json})"
      end
    end

    helpers GeneralHelper
  end
end
