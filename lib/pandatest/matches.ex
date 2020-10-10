defmodule Pandatest.Matches do
  @moduledoc """
  The Matches context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Matches.Match

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

  Note: assumption, if/when the API returns some data it is always "well-formed".
  """
  def winning_probabilities_for_match(match_id) do
    %{}
    # TODO
    # {:ok, match} = get_match(match_id)
    #
    # opponent_matches =
    # match.opponnents
    # |> Enum.map(fn opponent -> Task.async(fn -> get_match_for_opponent(opponent) end) end)
    # |> Enum.map(fn task -> Task.await(task) end)
    #
    # Enum.zip(match.opponnents, opponent_matches)
    # |> compute_basic_winning_probabilities()
  end

  defp get_match_for_opponent(%{type: "player", opponnent: opponnent}) do
    []
  end

  defp get_match_for_opponent(%{type: "team", opponnent: opponnent}) do
    []
  end

  defp compute_basic_winning_probabilities(_) do
    %{}
  end
end
