import Config

if System.get_env("PHX_SERVER") do
  config :mattbilbow_blog, MattbilbowBlogWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise "environment variable DATABASE_URL is missing"

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "environment variable SECRET_KEY_BASE is missing"

  host = System.get_env("PHX_HOST")
  host = if host && host != "", do: host, else: "localhost"

  port = String.to_integer(System.get_env("PORT") || "4000")

  config :mattbilbow_blog, MattbilbowBlogWeb.Endpoint,
         url: [host: host, port: 443, scheme: "https"],
         http: [
           ip: {0, 0, 0, 0, 0, 0, 0, 0},
           port: port
         ],
         secret_key_base: secret_key_base

  config :mattbilbow_blog, MattbilbowBlog.Repo,
         url: database_url,
         pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
         ssl: [
           verify: :verify_none,
           versions: [:"tlsv1.2", :"tlsv1.3"]
         ]
end