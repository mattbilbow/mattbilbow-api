defmodule MattbilbowBlogWeb.API.AuthController do
  use MattbilbowBlogWeb, :controller

  alias MattbilbowBlog.Accounts
  alias MattbilbowBlog.Accounts.Token

  action_fallback MattbilbowBlogWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email_and_password(email, password) do
      %Accounts.User{} = user ->
        case Token.generate_token(user.id) do
          {:ok, token, _claims} ->
            conn
            |> put_status(:ok)
            |> json(%{
              token: token,
              user: %{
                id: user.id,
                email: user.email
              }
            })
          {:error, _reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Could not generate token"})
        end
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end

  def register(conn, %{"email" => email, "password" => password}) do
    case Accounts.create_user(%{email: email, password: password}) do
      {:ok, user} ->
        case Token.generate_token(user.id) do
          {:ok, token, _claims} ->
            conn
            |> put_status(:created)
            |> json(%{
              token: token,
              user: %{
                id: user.id,
                email: user.email
              }
            })
          {:error, _reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Could not generate token"})
        end
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end