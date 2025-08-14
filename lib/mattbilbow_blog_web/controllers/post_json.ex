defmodule MattbilbowBlogWeb.PostJSON do
  def index(%{posts: posts}) do
    %{data: for(post <- posts, do: data(post))}
  end

  def show(%{post: post}) do
    %{data: data(post)}
  end

  defp data(post) do
    %{
      id: post.id,
      title: post.title,
      description: post.description,
      content: post.content,
      created_at: post.inserted_at,
      category: category_data(post.category)
    }
  end

  defp category_data(nil), do: nil
  defp category_data(category) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug
    }
  end
end