class Article < ActiveRecord::Base
  belongs_to :category
  after_save :clean_cache
  before_destroy :clean_cache

  def self.search(q)
    self.where('body like ?', "%#{q}%")
  end

  def self.per_page
    10
  end

  def self.page(n)
    self.limit(per_page).offset((n - 1) * per_page)
  end

  def clean_cache
    ::CicholBlog::App::cache.delete("/article/#{self.id}")
    ::CicholBlog::App::cache.delete("/category/#{self.category.id}")
    ::CicholBlog::App::cache.delete("/")
  end
end
