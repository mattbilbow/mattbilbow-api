defmodule MattbilbowBlogWeb.Plugs.APIAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias MattbilbowBlog.Accounts
  alias MattbilbowBlog.Accounts.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> verify_token(conn, token)
      _ -> unauthorized(conn)
    end
  end

  defp verify_token(conn, token) do
    case Token.verify_token(token) do
      {:ok, %{"user_id" => user_id}} ->
        user = Accounts.get_user!(user_id)
        assign(conn, :current_user, user)
      {:error, _} ->
        unauthorized(conn)
    end
  rescue
    Ecto.NoResultsError -> unauthorized(conn)
  end

  defp unauthorized(conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Authentication required"})
    |> halt()
  end
end