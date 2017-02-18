# Generic Server

The abstraction behind Elixir's [Genserver](https://hexdocs.pm/elixir/GenServer.html).

In your interactive shell, run:

```
iex1> pid = Store.start

iex2> Store.put(pid, :some_key, :some_value)

iex3> Store.get(pid, :some_key)
:some_value
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `todo` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:todo, "~> 0.1.0"}]
    end
    ```

  2. Ensure `todo` is started before your application:

    ```elixir
    def application do
      [applications: [:todo]]
    end
    ```

# generic-server
