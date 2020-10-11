defmodule PandatestWeb.MatchView do
  use PandatestWeb, :view

  def render("winning_probabilities.json", %{probabilities: probabilities}) do
    %{data: probabilities}
  end

  def render("winning_probabilities_error.json", %{reason: reason}) do
    %{error: true, reason: reason}
  end
end
