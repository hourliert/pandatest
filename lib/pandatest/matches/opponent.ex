defmodule Pandatest.Matches.Opponent do
  defstruct [:type, :opponent]

  alias Pandatest.Matches.{Player, Team}

  def from_api(%{"type" => "Player", "opponent" => o}) do
    %__MODULE__{
      type: "Player",
      opponent: Player.from_api(o)
    }
  end

  def from_api(%{"type" => "Team", "opponent" => o}) do
    %__MODULE__{
      type: "Team",
      opponent: Team.from_api(o)
    }
  end
end
