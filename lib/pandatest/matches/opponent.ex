defmodule Pandatest.Matches.Opponent do
  defstruct [:type, :opponent]

  alias Pandatest.Matches.{Player, Team}

  def from_api(%{"type" => "player", "opponent" => o}) do
    %__MODULE__{
      type: "player",
      opponent: Player.from_api(o)
    }
  end

  def from_api(%{"type" => "team", "opponent" => o}) do
    %__MODULE__{
      type: "team",
      opponent: Team.from_api(o)
    }
  end
end
