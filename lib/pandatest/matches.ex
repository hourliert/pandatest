defmodule Pandatest.Matches do
  @moduledoc """
  The Matches context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Matches.Match

  def upcoming_matches do
    ApiClient.upcoming_matches(count: 5)
    |> parse_matches()
  end

  defp parse_matches({:ok, matches}) do
    matches
    |> Enum.map(fn match_payload ->
      Match.from_api(match_payload)
    end)
  end

  defp parse_matches({:error, reason}) do
    {:error, "Couldn't parse matches because of: #{reason}"}
  end
end
