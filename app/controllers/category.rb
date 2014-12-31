CicholBlog::App.controllers :category, :cache => true do
  
  get :home, :map=>'/' do 
    @articles = Article.where('visible=1').order('id DESC').all
    @title = "Cichol"
    render :list
  end

  get :show, :map=>'/category/:id' do
    category = Category.find_by(id: params[:id]) or halt 404
    @articles = category.articles.where('visible=1').order('id DESC').all
    @title = category.name
    render :list
  end

end
