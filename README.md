# Pandatest

## Get started

- You need [elixir](https://elixir-lang.org/install.html) 1.7 or above.
- Clone this repo, then in the repo folder:
- `mix deps.get` to install dependencies

## Running the tests

- Run `mix test`

### Running the server

#### Development mode

- Update the file `config/dev.exs` with your own PANDASCORE_API_KEY (line 63)
- Run `mix phx.server` or `iex -S mix`

#### Production mode

- Export your pandascore API KEY: `export PANDASCORE_API_KEY="SOMETHING"`
- Export your a secret key: `export SECRET_KEY_BASE="SOMETHING_ELSE"`
- Run `MIX_ENV=prod mix phx.server`
- Visit [http://localhost:4000/matches/9493/winning_probabilities](http://localhost:4000/matches/9493/winning_probabilities) to view the winning probabilities of the match Giants VS Origen

Note:
I have skipped packaging this as a Mix Release. But it should be straighforward from here. Just rename `config/prod.secret.exs` to `config/runtime.exs` and run `MIX_ENV=prod mix release`.

## Part 1: Upcoming Matches

Please run `iex -S mix <<< "Pandatest.Matches.upcoming_matches"`
Output should be something of that sort (depending on upcoming matches).

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

## Part 2: Basic winning probabilities

Please run `iex -S mix <<< "Pandatest.Matches.winning_probabilities_for_match(9493)"`
Output should be:

```
iex(1)> %{"Giants" => 0.46, "Origen" => 0.54}
```

The probability algorithm is explained in the doc of the Matches context in `lib/pandatest/matches.ex`.

## Part 3: REST API serving the winning probabilities

If the server has been started from the above step, please visit: [http://localhost:4000/matches/9493/winning_probabilities](http://localhost:4000/matches/9493/winning_probabilities) to view the winning probabilities of the match Giants VS Origen.
You should see something like this: `{"data":{"Giants":0.46,"Origen":0.54}}`

If you load the data for a unknown match, you should see: `{"error":true,"reason":"Couldn't get matches because of: Pandascore API error: 404"}`

## Notes

- I didn't implement a cache for API requests. However, I described in `lib/pandatest/api_client.ex` a possible cache implementation.
- The different API requests (in `winning_probabilities_for_match`) are parallelized where possible
- I have tested the apps (high level tests in the controller, and unit tests in deeper files)
  - I have used ExVCR to test the Pandscore API Client so that I am not expose to network and therfore flake.
  - I have created an InMemory Pandscore API client so that functions that depend on it are deterministc during tests
  - In an ideal world, I would probably use `Ecto.Schema` for my domain models. That would also make stubbing simpler with `ExMachina`. I started without it for this project and didn't want to spend the time to refactor.
