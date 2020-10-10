defmodule Pandatest.Matches.Match do
  defstruct [:id, :scheduled_at, :name, :opponents, :winner_id]

  alias Pandatest.Matches.Opponent

  def from_api(payload) do
    %__MODULE__{
      id: payload["id"],
      scheduled_at: payload["scheduled_at"],
      name: payload["name"],
      opponents: parse_opponents(payload),
      winner_id: payload["winner_id"]
    }
  end

  defp parse_opponents(%{"opponents" => opponents}) when length(opponents) > 0 do
    Enum.map(opponents, fn opponent ->
      Opponent.from_api(opponent)
    end)
  end

  defp parse_opponents(_), do: []
end
