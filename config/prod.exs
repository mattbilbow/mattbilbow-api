import Config

config :mattbilbow_blog, MattbilbowBlogWeb.Endpoint,
  url: [port: 443, scheme: "https"],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :mattbilbow_blog, MattbilbowBlog.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
