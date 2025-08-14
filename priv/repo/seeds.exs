# priv/repo/seeds.exs

alias MattbilbowBlog.Repo
alias MattbilbowBlog.Blog.Post

# Example post
%Post{
  title: "Welcome to my blog",
  content: "This is a sample post",
  published: true
} |> Repo.insert!()