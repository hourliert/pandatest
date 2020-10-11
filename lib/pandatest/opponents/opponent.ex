defmodule Pandatest.Opponents.Opponent do
  defstruct [:type, :opponent, :matches, :win_ratio]

  alias Pandatest.Opponents.{Player, Team}

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

  def change(%__MODULE__{} = opponent, attrs) do
    Map.merge(opponent, attrs)
  end
end
