defmodule Pandatest.ApiClient.InMemory do
  def get_match(_id) do
    %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2020-10-10 14:10:10Z]}
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
end
