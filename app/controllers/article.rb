CicholBlog::App.controllers :article, :cache => true do
  
  get :show, :map=>'/article/:id' do
    @article = Article.find_by(id: params[:id]) or halt 404
    @title = @article.title
    render :show
  end

  get :show_json, :map=>'/article/:id/jsonp' do
    content_type 'text/javascript'
    @article = Article.find_by(id: params[:id])
    body = render(:show, layout: false)
    article_hash = {
      :title => @article.title,
      :body => body
    }
    "show(#{article_hash.to_json})"
  end
end
