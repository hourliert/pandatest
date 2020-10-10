defmodule Pandatest.Repo do
  use Ecto.Repo,
    otp_app: :pandatest,
    adapter: Ecto.Adapters.Postgres
end
