defmodule MattbilbowBlogWeb.CategoryJSON do
  def index(%{categories: categories}) do
    %{data: for(category <- categories, do: data(category))}
  end

  defp data(category) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug
    }
  end
end