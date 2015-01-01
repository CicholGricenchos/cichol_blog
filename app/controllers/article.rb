CicholBlog::App.controllers :article, :cache => true do
  
  get :show, :map=>'/article/:id' do
    @article = Article.find_by(id: params[:id]) or halt 404
    @title = @article.title
    render :show
  end

end
