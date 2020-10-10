defmodule Pandatest.ApiClient.InMemory do
  def get_match(_id) do
    {:ok,
     %{
       "id" => 1,
       "name" => "Rhyno vs Baecon",
       "scheduled_at" => ~U[2020-10-10 14:10:10Z],
       "opponents" => [
         %{"type" => "player", "opponent" => %{"id" => 1, "name" => "Thomas"}},
         %{"type" => "player", "opponent" => %{"id" => 2, "name" => "Leo"}}
       ]
     }}
  end

  def upcoming_matches(count: _count) do
    {:ok,
     [
       %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 2, "name" => "Cloud9 vs MSI", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 3, "name" => "Fnatic vs HyperX", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 4, "name" => "Light vs Flash", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 5, "name" => "Xbox vs Underdog", "scheduled_at" => ~U[2020-10-10 16:10:10Z]}
     ]}
  end

  def get_matches_for_team(_team_id) do
    {:ok,
     [
       %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 2, "name" => "Cloud9 vs MSI", "scheduled_at" => ~U[2020-10-10 14:10:10Z]},
       %{"id" => 3, "name" => "Fnatic vs HyperX", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 4, "name" => "Light vs Flash", "scheduled_at" => ~U[2020-10-10 15:10:10Z]},
       %{"id" => 5, "name" => "Xbox vs Underdog", "scheduled_at" => ~U[2020-10-10 16:10:10Z]}
     ]}
  end

  def get_matches_for_player(_player_id) do
    {:error, "Pandascore API error: 403"}
  end
end
