defmodule Pandatest.ApiClient do
  alias Pandatest.Matches.{Match}

  def get_match(id) do
    api_client().get_match(id)
    |> parse_match_or_matches()
  end

  def upcoming_matches(count: count) do
    api_client().upcoming_matches(count: count)
    |> parse_match_or_matches()
  end

  def get_matches_for_team(team_id) do
    api_client().get_matches_for_team(team_id)
    |> parse_match_or_matches()
  end

  def get_matches_for_player(player_id) do
    api_client().get_matches_for_player(player_id)
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

  defp api_client do
    Application.get_env(:pandatest, :pandascore_client)
  end
end
