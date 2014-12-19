class Article < ActiveRecord::Base
  belongs_to :category
  after_save :clean_cache
  before_destroy :clean_cache

  def clean_cache
    ::CicholBlog::App::cache.delete("/article/#{self.id}")
    ::CicholBlog::App::cache.delete("/category/#{self.category.id}")
    ::CicholBlog::App::cache.delete("/")
  end
end
