defmodule Pandatest.ApiClient do
  alias Pandatest.Matches.Match

  def get_match(id) do
    api_client().get_match(id)
  end

  def upcoming_matches(count: count) do
    api_client().upcoming_matches(count: count)
  end

  defp api_client do
    Application.get_env(:pandatest, :pandascore_client)
  end
end
