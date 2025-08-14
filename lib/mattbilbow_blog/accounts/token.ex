defmodule MattbilbowBlog.Accounts.Token do
  use Joken.Config

  @impl Joken.Config
  def token_config do
    default_claims(skip: [:aud])
    |> add_claim("user_id", nil, &is_integer/1)
  end

  def generate_token(user_id) do
    extra_claims = %{"user_id" => user_id}
    generate_and_sign(extra_claims)
  end

  def verify_token(token) do
    verify_and_validate(token)
  end
end