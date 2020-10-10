defmodule Pandatest.MatchesTest do
  use Pandatest.DataCase

  alias Pandatest.Matches

  describe "matches" do
    alias Pandatest.Matches.Match

    test "upcoming_matches/0 returns the 5 first upcoming_matches" do
      assert Matches.upcoming_matches() == [
               %Match{id: 1, name: "Rhyno vs Baecon", scheduled_at: ~U[2010-10-10 10:10:10Z]}
             ]
    end
  end
end
