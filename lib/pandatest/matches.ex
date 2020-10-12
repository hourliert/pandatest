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

  Note: I decided to respect the function signature from the gist. Passing the count of upcoming matches to ease testing with the InMemory client.
  """
  def upcoming_matches(count \\ 5) do
    ApiClient.upcoming_matches(count: count)
  end

  @doc """
  Returns the basic winning probablities for each opponent of a match.

  The probabilities for a match are computed according to the following definition:
  Let A and B 2 opponents:
  We assume A has a win ratioa, wa and B has a win ratio, wb (this win ratio is computed by looking at previous matches).

  Then in a match A vs B:
  P(A wins) = (wa + (1 - wb)) / 2
  P(B wins) = ((1 - wa) + wb) / 2

  Let C a third opponent with a win ratio wc.

  Then in a match A vs B vs C:
  P(A wins) = ((P(A wins B) + P(B loses A)) * (P(A wins C) + P(C loses A))) / 3
  P(B wins) = ((P(B wins A) + P(A loses B)) * (P(B wins C) + P(C loses B))) / 3
  P(C wins) = ((P(C wins A) + P(A loses C)) * (P(C wins B) + P(B loses C))) / 3

  This can be expanded to any n opponents.

  Please look at the tests for some examples.

  Note: assumption: if/when the API returns some data it is always "well-formed". Eg.
  * A match always have at least 2 opponents.
  * If an opponent has never played any match before, then their win rate is 0.5 (50% to win/lose)
  """
  def winning_probabilities_for_match(match_id) do
    case get_match(match_id) do
      {:error, _} = e ->
        e

      match ->
        match.opponents
        |> Enum.map(fn o -> Task.async(fn -> Opponents.load_opponent_matches(o) end) end)
        |> Enum.map(fn t -> Task.await(t) end)
        |> Enum.map(&Opponents.compute_opponent_win_ratio/1)
        |> compute_match_probabilities()
    end
  end

  defp compute_match_probabilities(opponents) do
    opponents
    |> sum_opponent_win_loss_probabilities()
    |> normalize_win_probabilities()
    |> format_win_probabilities()
  end

  defp sum_opponent_win_loss_probabilities(opponents) do
    opponents
    |> Enum.reduce(%{}, fn opponent, acc ->
      win_probability =
        Enum.reduce(opponents, 1, fn other_opponent, win_probability ->
          cond do
            other_opponent == opponent ->
              win_probability

            true ->
              win_probability *
                (Opponents.win_probability(opponent, other_opponent) +
                   Opponents.loss_probability(other_opponent, opponent))
          end
        end)

      Map.put(acc, opponent, win_probability)
    end)
  end

  defp normalize_win_probabilities(win_probabilities) do
    Enum.map(win_probabilities, fn {opponent, win_probability} ->
      {opponent, win_probability / Map.size(win_probabilities)}
    end)
    |> Enum.into(%{})
  end

  defp format_win_probabilities(win_probabilities) do
    Enum.map(win_probabilities, fn {opponent, win_probability} ->
      {opponent.opponent.name, win_probability |> Float.round(3)}
    end)
    |> Enum.into(%{})
  end
end
