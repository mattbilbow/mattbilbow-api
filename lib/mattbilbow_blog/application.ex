defmodule MattbilbowBlog.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MattbilbowBlogWeb.Telemetry,
      MattbilbowBlog.Repo,
      {DNSCluster, query: Application.get_env(:mattbilbow_blog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MattbilbowBlog.PubSub},
      MattbilbowBlogWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: MattbilbowBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MattbilbowBlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
