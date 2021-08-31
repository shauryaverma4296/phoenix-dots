defmodule Dots.Repo do
  use Ecto.Repo,
    otp_app: :dots,
    adapter: Ecto.Adapters.Postgres
end
