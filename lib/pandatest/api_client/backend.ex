defmodule Pandatest.ApiClient.Backend do
  use HTTPoison.Base

  @api_token Application.get_env(:pandatest, :pandascore_token)

  def get_match(id) do
    get("/matches/#{id}", headers())
    |> format_response()
  end

  def upcoming_matches(count: count) do
    get("/matches/upcoming?page[size]=#{count}", headers())
    |> format_response()
  end

  def get_matches_for_team(team_id) do
    get("/teams/#{team_id}/matches", headers())
    |> format_response()
  end

  def get_matches_for_player(player_id) do
    get("/players/#{player_id}/matches", headers())
    |> format_response()
  end

  def process_request_url(url) do
    "https://api.pandascore.co" <> url
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end

  def format_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, "Pandascore API error: #{status}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp headers do
    [Authorization: "Bearer #{@api_token}"]
  end
end
