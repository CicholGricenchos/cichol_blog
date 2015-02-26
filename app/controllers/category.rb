CicholBlog::App.controllers :category, :cache => true do

  get :home, :map=>'/api/index/' do 
    articles = Article.where('visible=1')
    pagination = paginate?(articles, current_page)
    articles = articles.page(current_page).order('id DESC').all
    articles.each{|a| a.body = truncate(GitHub::Markdown.render(a.body), :length=>240).gsub(/<hr>[\s\S]*/, '').html_safe }
    hs = {}
    articles = articles.collect{|a| a.attributes.merge({category: a.category})}
    hs[:articles] = articles
    hs[:pagination] = pagination
    hs[:page] = current_page
    hs.to_json
  end

  get :show, :map=>'/api/category/:id' do
    category = Category.find_by(id: params[:id]) or halt 404
    articles = category.articles.where('visible=1')
    pagination = paginate?(articles, current_page)
    articles = articles.page(current_page).order('id DESC').all
    articles.each{|a| a.body = truncate(GitHub::Markdown.render(a.body), :length=>240).gsub(/<hr>[\s\S]*/, '').html_safe }
    hs = {}
    articles = articles.collect{|a| a.attributes.merge({category: a.category})}
    hs[:articles] = articles
    hs[:pagination] = pagination
    hs[:page] = current_page
    hs.to_json
  end

  get :search, :map=>'/api/search/:s' do
    articles = Article.where('visible=1').search(params[:s])
    pagination = paginate?(articles, current_page)
    articles = articles.page(current_page).order('id DESC').all
    title = "搜索 #{params[:s]}"
    articles.each{|a| a.body = truncate(GitHub::Markdown.render(a.body), :length=>240).gsub(/<hr>[\s\S]*/, '').html_safe }
    hs = {}
    articles = articles.collect{|a| a.attributes.merge({category: a.category})}
    hs[:articles] = articles
    hs[:pagination] = pagination
    hs.to_json
  end
end
