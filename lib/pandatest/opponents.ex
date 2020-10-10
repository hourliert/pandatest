defmodule Pandatest.Opponents do
  @moduledoc """
  The Opponents context.
  """

  alias Pandatest.Matches.Opponent

  def get_opponent_win_probability(%Opponent{} = opponent, matches) do
    %{wins: wins, losses: losses} =
      Enum.reduce(matches, %{wins: 0, losses: 0}, fn match, acc ->
        cond do
          match.winner_id == opponent.opponent.id ->
            %{acc | wins: acc[:wins] + 1}

          true ->
            %{acc | losses: acc[:losses] + 1}
        end
      end)

    wins / (wins + losses)
  end
end
