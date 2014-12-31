# Helper methods defined here can be accessed in any controller or view in the application

module CicholBlog
  class App
    module GeneralHelper
      def rand_for_str(arr)
        arr[(rand(arr.size))]
      end

      def nav?(path)
        request.path == path ? 'current_page_item' : 'page_item'       
      end

    end

    helpers GeneralHelper
  end
end
