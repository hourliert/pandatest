defmodule Pandatest.Matches do
  @moduledoc """
  The Matches context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Matches.Match
  alias Pandatest.Opponents

  @doc """
  Returns a match by id.
  """
  def get_match(id) do
    ApiClient.get_match(id)
    |> parse_match_or_matches()
  end

  @doc """
  Returns the 5 upcoming matches from Pandascore API.

  Note: Easily extensible, I decided to respect the function signature from the Gist file.
  """
  def upcoming_matches do
    ApiClient.upcoming_matches(count: 5)
    |> parse_match_or_matches()
  end

  defp parse_match_or_matches({:ok, matches_payload}) when is_list(matches_payload) do
    matches_payload
    |> Enum.map(fn match_payload ->
      Match.from_api(match_payload)
    end)
  end

  defp parse_match_or_matches({:ok, match_payload}) do
    Match.from_api(match_payload)
  end

  defp parse_match_or_matches({:error, reason}) do
    {:error, "Couldn't get matches because of: #{reason}"}
  end

  @doc """
  Returns the basic winning probablities for each opponent of a match.

  Note: assumption: if/when the API returns some data it is always "well-formed".
  """
  def winning_probabilities_for_match(match_id) do
    match = get_match(match_id)

    opponents_matches =
      match.opponents
      |> Enum.map(fn opponent -> Task.async(fn -> get_match_for_opponent(opponent) end) end)
      |> Enum.map(fn task -> Task.await(task) end)

    compute_match_probabilities(match.opponents, opponents_matches)
  end

  defp get_match_for_opponent(%{type: "Player", opponent: opponent}) do
    ApiClient.get_matches_for_player(opponent.id)
    |> parse_match_or_matches()
  end

  defp get_match_for_opponent(%{type: "Team", opponent: opponent}) do
    ApiClient.get_matches_for_team(opponent.id)
    |> parse_match_or_matches()
  end

  defp compute_match_probabilities(opponents, matches) do
    win_ratios = compute_opponent_win_ratios(opponents, matches)

    win_probabilities =
      Enum.reduce(opponents, %{}, fn o, acc -> Map.put(acc, o.opponent.name, 0) end)

    Enum.zip(opponents, win_ratios)
    |> Enum.reduce(win_probabilities, fn {opponent, win_ratio}, acc ->
      Enum.map(acc, fn {k, v} ->
        {k, v + if(k == opponent.opponent.name, do: win_ratio, else: 1 - win_ratio)}
      end)
    end)
    |> Enum.map(fn {k, v} ->
      {k, v / length(opponents)}
    end)
  end

  defp compute_opponent_win_ratios(opponents, opponents_matches) do
    Enum.zip(opponents, opponents_matches)
    |> Enum.map(fn {opponent, matches} ->
      Opponents.get_opponent_win_probability(opponent, matches)
    end)
  end
end
