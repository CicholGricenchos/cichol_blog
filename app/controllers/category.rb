CicholBlog::App.controllers :category, :cache => true do
  
  get :home, :map=>'/' do 
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

  get :home_json, :map=>'/home/jsonp' do
    @articles = Article.order('id DESC').all
    body = render(:list_js, layout: false)
    list_hash = {
      title: "Mabinogion",
      body: body
    }
    content_type 'text/javascript'
    "show(#{list_hash.to_json})"
  end

  get :show_json, :map=>'/category/:id/jsonp' do
    category = Category.find_by(id: params[:id])
    @articles = category.articles.order('id DESC').all
    @title = category.name
    body = render(:list_js, layout: false)
    list_hash = {
      title: category.name,
      body: body
    }
    content_type 'text/javascript'
    "show(#{list_hash.to_json})"
  end
end
