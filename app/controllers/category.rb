CicholBlog::App.controllers :category, :cache => true do
  
  get :home, :map=>'/' do 
    @articles = Article.where('visible=1')
    @pagination = paginate?(@articles, current_page)
    @articles = @articles.page(current_page).order('id DESC').all
    @title = "Cichol"
    render :list
  end

  get :show, :map=>'/category/:id' do
    category = Category.find_by(id: params[:id]) or halt 404
    @articles = category.articles.where('visible=1')
    @pagination = paginate?(@articles, current_page)
    @articles = @articles.page(current_page).order('id DESC').all
    @title = category.name
    render :list
  end

  get :search, :map=>'/search' do
    @articles = Article.where('visible=1').search(params[:s])
    @pagination = paginate?(@articles, current_page)
    @articles = @articles.page(current_page).order('id DESC').all
    @title = "搜索 #{params[:s]}"
    p params
    render :list
  end
end
