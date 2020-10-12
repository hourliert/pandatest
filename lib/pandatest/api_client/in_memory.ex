defmodule Pandatest.ApiClient.InMemory do
  @doc """
  API fixtures for get_match.
  """
  def get_match("match_with_opponents") do
    {:ok,
     %{
       "id" => "match_with_opponents",
       "name" => "Rhyno vs Baecon",
       "scheduled_at" => ~U[2020-10-10 14:10:10Z],
       "opponents" => [
         %{"type" => "Player", "opponent" => %{"id" => "thomas", "name" => "Thomas"}},
         %{"type" => "Player", "opponent" => %{"id" => "leo", "name" => "Leo"}}
       ]
     }}
  end

  def get_match("match_with_opponents_for_win_probabilities") do
    {:ok,
     %{
       "id" => "match_with_opponents_for_win_probabilities",
       "name" => "Fnatic vs Baecon",
       "scheduled_at" => ~U[2020-10-10 14:10:10Z],
       "opponents" => [
         %{"type" => "Team", "opponent" => %{"id" => "fnatic", "name" => "Fnatic"}},
         %{"type" => "Team", "opponent" => %{"id" => "baecon", "name" => "Baecon"}}
       ]
     }}
  end

  def get_match("match_with_new_opponents_for_win_probabilities") do
    {:ok,
     %{
       "id" => "match_with_new_opponents_for_win_probabilities",
       "name" => "Fnatic vs Newcomer",
       "scheduled_at" => ~U[2020-10-10 14:10:10Z],
       "opponents" => [
         %{"type" => "Team", "opponent" => %{"id" => "fnatic", "name" => "Fnatic"}},
         %{"type" => "Team", "opponent" => %{"id" => "newcomer", "name" => "Newcomer"}}
       ]
     }}
  end

  def get_match("match_with_three_opponents_for_win_probabilities") do
    {:ok,
     %{
       "id" => "match_with_three_opponents_for_win_probabilities",
       "name" => "Fnatic vs Baecon vs Newcomer",
       "scheduled_at" => ~U[2020-10-10 14:10:10Z],
       "opponents" => [
         %{"type" => "Team", "opponent" => %{"id" => "fnatic", "name" => "Fnatic"}},
         %{"type" => "Team", "opponent" => %{"id" => "newcomer", "name" => "Newcomer"}},
         %{"type" => "Team", "opponent" => %{"id" => "baecon", "name" => "Baecon"}}
       ]
     }}
  end

  def get_match("match_with_server_error") do
    {:error, "something"}
  end

  def get_match(_) do
    {:error, "404"}
  end

  @doc """
  API fixtures for upcoming_matches.
  """
  def upcoming_matches(count: 5) do
    {:ok,
     [
       %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 2, "name" => "Cloud9 vs MSI", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 3, "name" => "Fnatic vs HyperX", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 4, "name" => "Light vs Flash", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 5, "name" => "Xbox vs Underdog", "scheduled_at" => ~U[2020-10-10 16:10:10Z]}
     ]}
  end

  def upcoming_matches(count: "with_error") do
    {:error, "something"}
  end

  def upcoming_matches(count: _) do
    {:error, "404"}
  end

  @doc """
  API fixtures for get_matches_for_team.
  """
  def get_matches_for_team("rhyno") do
    {:ok,
     [
       %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2020-10-10 14:10:10Z]}
     ]}
  end

  def get_matches_for_team("fnatic") do
    {:ok,
     [
       %{
         "id" => 1,
         "name" => "Fnatic vs A",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "fnatic"
       },
       %{
         "id" => 1,
         "name" => "Fnatic vs B",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "B"
       },
       %{
         "id" => 1,
         "name" => "Fnatic vs C",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "fnatic"
       }
     ]}
  end

  def get_matches_for_team("baecon") do
    {:ok,
     [
       %{
         "id" => 1,
         "name" => "Baecon vs A",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "baecon"
       },
       %{
         "id" => 1,
         "name" => "Baecon vs B",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "B"
       },
       %{
         "id" => 1,
         "name" => "Baecon vs C",
         "scheduled_at" => ~U[2020-10-10 14:10:10Z],
         "winner_id" => "C"
       }
     ]}
  end

  def get_matches_for_team("newcomer"), do: {:ok, []}

  def get_matches_for_team("id_with_error") do
    {:error, "something"}
  end

  def get_matches_for_team(_) do
    {:error, "404"}
  end

  @doc """
  API fixtures for get_matches_for_player.
  """
  def get_matches_for_player("thomas") do
    {:ok,
     [
       %{"id" => 1, "name" => "Thomas vs Leo", "scheduled_at" => ~U[2020-10-10 14:10:10Z]}
     ]}
  end

  def get_matches_for_player("leo") do
    {:ok,
     [
       %{"id" => 1, "name" => "Leo vs Yolo", "scheduled_at" => ~U[2020-10-10 14:10:10Z]}
     ]}
  end

  def get_matches_for_player("id_with_error") do
    {:error, "something"}
  end

  def get_matches_for_player(_) do
    {:error, "404"}
  end
end
