defmodule MattbilbowBlog.Blog do
  import Ecto.Query, warn: false
  alias MattbilbowBlog.Repo
  alias MattbilbowBlog.Blog.{Post, Category}

  def list_posts do
    Post
    |> preload(:category)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
    |> case do
         {:ok, post} -> {:ok, Repo.preload(post, :category)}
         error -> error
       end
  end

  def get_post(id) do
    case Repo.get(Post, id) |> Repo.preload(:category) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end

  def update_post(id, attrs) do
    case get_post(id) do
      {:ok, post} ->
        post
        |> Post.changeset(attrs)
        |> Repo.update()
        |> case do
             {:ok, updated_post} -> {:ok, Repo.preload(updated_post, :category)}
             error -> error
           end
      {:error, :not_found} ->
        {:error, :not_found}
    end
  end

  def delete_post(id) do
    case get_post(id) do
      {:ok, post} ->
        Repo.delete(post)
      {:error, :not_found} ->
        {:error, :not_found}
    end
  end

  def list_categories do
    Category
    |> order_by(:name)
    |> Repo.all()
  end

  def get_category(id) do
    Repo.get(Category, id)
  end
end