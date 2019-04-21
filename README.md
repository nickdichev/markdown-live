# MarkdownLive

## About

MarkdownLive is an example application for [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view).

When a client connects to the server they are initially served some HTML content. In our case, what is initially rendered is a textarea prepopulated with some Markdown and the HTML view of that Markdown. However, this is where things get interesting. A websocket connection is opened between the client and the server. The server listens for changes in the textbox, re-renders the HTML, and sends the smallest possible change back to the client which then updates the DOM.

All of this is powered by Phoenix LiveView and the Earmark Elixir library. I used this as application as my first introduction to LiveView and I really enjoyed it. It was so simple to get the functionality working (in fact, I spent more time wrestling with CSS than Elixir...), and I can't imagine the headache I would have gone through to get this working with JavaScript.

Additionally, I wanted to learn about deployment with Kubernetes. You can see an example of this application running [here](http://markdown.dichev.io).

## Usage

### Mix

The application can be run with `mix`, however, first you need to find the absolute path to `docker/default.md` in the repository.

```bash
export DEFAULT_MD="/Users/ndichev/Workspace/elixir-lab/markdown_live/docker/default.md"
mix phx.server
```

Now point your browser at [localhost:4000](localhost:4000) to see the application running!

### Docker

A `Dockerfile` is provided which can be used to compile and run the application:

```bash
docker build -t markdown_live:latest .
export COOKIE=$(mix phx.gen.secret 64)
docker run --env HOST="localhost" --env COOKIE="${COOKIE}" -p 4000:4000 --rm --name markdown_live markdown_live
```

You should be able to point your browser at [localhost:4000](localhost:4000) and see the application running!
