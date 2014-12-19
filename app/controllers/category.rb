CicholBlog::App.controllers :category, :cache => true do
  
  get :recent, :map=>'/' do 
    @articles = Article.order('id DESC').all
    @title = "Mabinogion"
    render :list
  end

  get :show, :map=>'/category/:id' do
    category = Category.find_by(id: params[:id]) or halt 404
    @articles = category.articles.order('id DESC').all
    @title = category.name
    render :list
  end

end
