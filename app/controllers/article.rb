CicholBlog::App.controllers :article, :cache => true do
  
  get :show, :map=>'/article/:id' do
    @article = Article.find_by(id: params[:id])
    halt 404 if @article.nil?
    @title = @article.title
    render :show
  end

end
