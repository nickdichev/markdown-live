defmodule MarkdownLiveWeb.PageController do
  use MarkdownLiveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
