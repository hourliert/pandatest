defmodule Pandatest.Opponents do
  @moduledoc """
  The Opponents context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Opponents.Opponent

  @doc """
  Load all matches for an opponent.

  Set the matches on the Opponent structure.
  """
  def load_opponent_matches(%Opponent{} = opponent) do
    case get_matches_for_opponent(opponent) do
      {:error, _} ->
        %{opponent | matches: []}

      matches ->
        %{opponent | matches: matches}
    end
  end

  defp get_matches_for_opponent(%Opponent{type: "Player", opponent: data}),
    do: ApiClient.get_matches_for_player(data.id)

  defp get_matches_for_opponent(%Opponent{type: "Team", opponent: data}),
    do: ApiClient.get_matches_for_team(data.id)

  @doc """
  Computes the win rate ratio of an opponent.

  If the opponent have never played any match, then his win_rate ratio arbitrary set to 0.5.
  Set the win ratio on the Opponent structure.
  """
  def compute_opponent_win_ratio(%Opponent{matches: matches} = opponent)
      when length(matches) > 0 do
    %{wins: wins, losses: losses} =
      Enum.reduce(matches, %{wins: 0, losses: 0}, fn match, acc ->
        cond do
          match.winner_id == opponent.opponent.id ->
            %{acc | wins: acc[:wins] + 1}

          true ->
            %{acc | losses: acc[:losses] + 1}
        end
      end)

    ratio =
      (wins / (wins + losses))
      |> Float.round(3)

    %{opponent | win_ratio: ratio}
  end

  def compute_opponent_win_ratio(%Opponent{} = opponent), do: %{opponent | win_ratio: 0.5}

  @doc """
  Computes the probability for the first opponent to win.

  P(A win) = P(A win B) + P(B loses A)
  """
  def win_probability(%Opponent{} = first, %Opponent{} = second) do
    (first.win_ratio + (1 - second.win_ratio)) / 2
  end

  @doc """
  Computes the probability for the first opponent to lose.

  P(A loses) = P(A loses B) + P(B wins A)
  """
  def loss_probability(%Opponent{} = first, %Opponent{} = second) do
    1 - win_probability(first, second)
  end
end
