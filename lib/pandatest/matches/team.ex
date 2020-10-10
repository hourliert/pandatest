defmodule Pandatest.Matches.Team do
  defstruct [:id, :name]

  def from_api(payload) do
    %__MODULE__{
      id: payload["id"],
      name: payload["name"]
    }
  end
end
