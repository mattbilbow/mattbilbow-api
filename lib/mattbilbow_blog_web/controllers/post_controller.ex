defmodule MattbilbowBlogWeb.PostController do
  use MattbilbowBlogWeb, :controller
  alias MattbilbowBlog.Blog

  action_fallback MattbilbowBlogWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, %{"data" => post_params}) do
    with {:ok, post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> render(:show, post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Blog.get_post(id) do
      render(conn, :show, post: post)
    end
  end

  def update(conn, %{"id" => id, "data" => post_params}) do
    with {:ok, post} <- Blog.update_post(id, post_params) do
      render(conn, :show, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _post} <- Blog.delete_post(id) do
      send_resp(conn, :no_content, "")
    end
  end
end