# Pandatest

0. Install

- You need [elixir](https://elixir-lang.org/install.html) 1.7 and above.
- Clone this repo, then in the repo folder:
- `mix deps.get` to install dependencies
- TODO: set your Pandascore API key as an env variable `PANDASCORE_API_KEY`

1. Upcoming Matches

---

Please run `iex -S mix <<< "Pandatest.Matches.upcoming_matches"`
Output should be something of that sort (depending upcoming matches).

```
iex(1)> [
  %Pandatest.Matches.Match{
    id: 573009,
    name: "Semifinal 2: Rhyno vs Baecon",
    scheduled_at: "2020-10-10T14:00:00Z"
  },
  %Pandatest.Matches.Match{
    id: 572827,
    name: "Upper Final: Nemiga vs Cyberium Seed",
    scheduled_at: "2020-10-10T14:55:00Z"
  },
  %Pandatest.Matches.Match{
    id: 573010,
    name: "Final: Giants vs TBD",
    scheduled_at: "2020-10-10T15:00:00Z"
  },
  %Pandatest.Matches.Match{
    id: 572548,
    name: " OG vs VK.gg",
    scheduled_at: "2020-10-10T15:00:00Z"
  },
  %Pandatest.Matches.Match{
    id: 572282,
    name: "Semifinal 1: Vitality vs FaZe",
    scheduled_at: "2020-10-10T15:30:00Z"
  }
]
```
