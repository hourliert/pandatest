defmodule Pandatest.Matches do
  @moduledoc """
  The Matches context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Opponents

  @doc """
  Returns a match by id.
  """
  def get_match(id) do
    ApiClient.get_match(id)
  end

  @doc """
  Returns the 5 upcoming matches from Pandascore API.

  Note: Easily extensible, I decided to respect the function signature from the Gist file.
  """
  def upcoming_matches do
    ApiClient.upcoming_matches(count: 5)
  end

  @doc """
  Returns the basic winning probablities for each opponent of a match.

  Note: assumption: if/when the API returns some data it is always "well-formed".
  """
  def winning_probabilities_for_match(match_id) do
    match = get_match(match_id)

    match.opponents
    |> Enum.map(fn o -> Task.async(fn -> Opponents.load_opponent_matches(o) end) end)
    |> Enum.map(fn t -> Task.await(t) end)
    |> Enum.map(&Opponents.compute_opponent_win_ratio/1)
    |> compute_match_probabilities()
  end

  defp compute_match_probabilities(opponents) do
    opponents
    |> sum_opponent_win_loose_probabilities()
    |> normalize_win_probabilities()
    |> format_win_probabilities()
  end

  defp sum_opponent_win_loose_probabilities(opponents) do
    win_probabilities =
      Enum.reduce(opponents, %{}, fn opponent, acc -> Map.put(acc, opponent, 0) end)

    Enum.reduce(opponents, win_probabilities, fn opponent, win_probabilities ->
      for {other_opponent, win_probability} <- win_probabilities do
        cond do
          other_opponent == opponent ->
            {other_opponent, win_probability + opponent.win_ratio}

          true ->
            {other_opponent, win_probability + 1 - opponent.win_ratio}
        end
      end
    end)
  end

  defp normalize_win_probabilities(win_probabilities) do
    Enum.map(win_probabilities, fn {opponent, win_probability} ->
      {opponent, win_probability / length(win_probabilities)}
    end)
  end

  defp format_win_probabilities(win_probabilities) do
    Enum.map(win_probabilities, fn {opponent, win_probability} ->
      {opponent.opponent.name, win_probability}
    end)
  end
end
