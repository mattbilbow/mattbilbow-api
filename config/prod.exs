import Config

config :mattbilbow_blog, MattbilbowBlogWeb.Endpoint,
  url: [port: 443, scheme: "https"],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :mattbilbow_blog, MattbilbowBlog.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

frontend_urls = case System.get_env("MATTBILBOW_UI") do
  nil -> []
  urls -> String.split(urls, ",") |> Enum.map(&String.trim/1)
end

config :cors_plug,
       origin: frontend_urls,
       max_age: 86400,
       methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
       headers: ["Authorization", "Content-Type", "Accept", "Origin", "User-Agent", "DNT", "Cache-Control", "X-Mx-ReqToken", "Keep-Alive", "X-Requested-With", "If-Modified-Since", "X-CSRF-Token"]