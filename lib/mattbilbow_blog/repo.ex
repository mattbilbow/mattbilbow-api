defmodule MattbilbowBlog.Repo do
  use Ecto.Repo,
    otp_app: :mattbilbow_blog,
    adapter: Ecto.Adapters.Postgres
end
