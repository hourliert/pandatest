defmodule Pandatest.ApiClient do
  def get_match(id) do
    api_client().get_match(id)
  end

  def upcoming_matches(count: count) do
    api_client().upcoming_matches(count: count)
  end

  def get_matches_for_team(team_id) do
    api_client().get_matches_for_team(team_id)
  end

  def get_matches_for_player(player_id) do
    api_client().get_matches_for_player(player_id)
  end

  defp api_client do
    Application.get_env(:pandatest, :pandascore_client)
  end
end
