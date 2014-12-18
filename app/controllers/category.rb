CicholBlog::App.controllers :category do
  
  get :recent, :map=>'/' do 
    @articles = Article.order('id DESC').all
    @title = "Mabinogion"
    render :list
  end

  get :show, :map=>'/category/:id' do
    category = Category.find(params[:id])
    @articles = category.articles.order('id DESC').all
    @title = category.name
    render :list
  end

end
