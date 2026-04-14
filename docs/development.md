# Development Setup

To get started with Elixir and Phoenix, follow the installation guide:
[https://hexdocs.pm/phoenix/installation.html](https://hexdocs.pm/phoenix/installation.html).

Besides the basic setup, you will also need a PostgreSQL server.

To connect to GitHub, callback URLs must be publicly reachable. Since GitHub cannot access your local machine directly,
you need a tunneling proxy.

I use Pinggy, but naturally ngrok or similar work too.

## Starting the local environment

To start your Phoenix server:

- Run `mix setup` to install and set up dependencies.
- Start the Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## AI Coding

There is also an open-source local AI setup using a local model.
The AI setup can be found in [ai.md](./ai.md).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

