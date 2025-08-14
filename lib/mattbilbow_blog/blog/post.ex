defmodule MattbilbowBlog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :description, :string
    field :content, :string

    belongs_to :category, MattbilbowBlog.Blog.Category

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :content, :category_id])
    |> validate_required([:title, :content])
    |> foreign_key_constraint(:category_id)
  end
end