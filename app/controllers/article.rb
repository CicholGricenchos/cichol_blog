CicholBlog::App.controllers :article, :cache => true do

  get :show, :map=>'/api/article/:id' do
    content_type 'text/json'
    @article = Article.find_by(id: params[:id]) or halt 404
    @article.body = GitHub::Markdown.render(@article.body).html_safe
    @article.attributes.merge({category: @article.category}).to_json
  end

  get :avalon_show, :map=>'/article/:id' do 
    render :show
  end

end
