CicholBlog::App.controllers :base do
  
  get :index, :map=>'/api/base' do
    content_type 'text/json'
    hs = {}
    hs[:categories] = Category.all
    hs[:micropost] = Micropost.last.body.gsub(/\n/, '<br>').html_safe
    hs[:recent_articles] = Article.where('visible = 1').order('id DESC').limit(5).all
    hs.to_json
  end
  

end
