defmodule PandatestWeb.MatchController do
  use PandatestWeb, :controller

  alias Pandatest.Matches

  def winning_probabilities(conn, %{"id" => id}) do
    case Matches.winning_probabilities_for_match(id) do
      {:error, reason} ->
        render(conn, "winning_probabilities_error.json", reason: reason)

      probabilities ->
        render(conn, "winning_probabilities.json", probabilities: probabilities)
    end
  end
end
