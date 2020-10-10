defmodule Pandatest.MatchesTest do
  use Pandatest.DataCase

  alias Pandatest.Matches

  describe "matches" do
    alias Pandatest.Matches.Match

    test "upcoming_matches/0 returns the 5 first upcoming_matches" do
      assert Matches.upcoming_matches() == []
    end
  end
end
