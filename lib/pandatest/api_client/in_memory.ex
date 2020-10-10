defmodule Pandatest.ApiClient.InMemory do
  def upcoming_matches(count: _count) do
    {:ok,
     [
       %{"id" => 1, "name" => "Rhyno vs Baecon", "scheduled_at" => ~U[2010-10-10 10:10:10Z]}
     ]}
  end
end
