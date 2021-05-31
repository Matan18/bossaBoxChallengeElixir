defmodule Bossabox.Repo do
  use Ecto.Repo,
    otp_app: :bossabox,
    adapter: Ecto.Adapters.Postgres
end
