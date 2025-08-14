defmodule MattbilbowBlogWeb.CategoryController do
  use MattbilbowBlogWeb, :controller
  alias MattbilbowBlog.Blog

  def index(conn, _params) do
    categories = Blog.list_categories()
    render(conn, :index, categories: categories)
  end
end