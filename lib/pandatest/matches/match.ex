defmodule Pandatest.Matches.Match do
  defstruct [:id, :scheduled_at, :name]

  def from_api(payload) do
    %__MODULE__{
      id: payload["id"],
      scheduled_at: payload["scheduled_at"],
      name: payload["name"]
    }
  end
end
