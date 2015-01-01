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

      def paginate?(resources, page)
        result = {:prev=> false, :next=> false}
        total_page = resources.count / (resources.klass.per_page + 1) + 1
        result[:prev] = true if page > 1
        result[:next] = true if page < total_page
        result
      end

      def current_page
        page = params[:page] || 1
        page.to_i
      end

      def join_params(arg = {})
        new_params = params.dup
        arg.each { |k,v| new_params[k.to_s] = v }
        new_params.delete('id')
        new_params = new_params.to_a
        "?#{new_params.collect{ |a| a.join('=') }.join('&')}"
      end
    end

    helpers GeneralHelper
  end
end
