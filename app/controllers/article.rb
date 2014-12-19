CicholBlog::App.controllers :article, :cache => true do
  
  get :show, :map=>'/article/:id' do
    @article = Article.find params[:id]
    @title = @article.title
    render :show
  end

end
