defmodule MarkdownLiveWeb.MarkdownLive do
  use Phoenix.LiveView
  alias MarkdownLiveWeb.MarkdownView

  @default_template ~s"""
  ## Markdown Live

  Type Github Flavored Markdown and see it rendered in real time!

  Note: If you're seeing this instead of some default Markdown you want to serve,
  you forgot to set the `DEFAULT_MD` environment variable.

  See the full code and documentation [here](https://github.com/nickdichev/markdown-live)
  """

  def render(assigns) do
    MarkdownView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    default_template =
      case System.get_env("DEFAULT_MD") do
        nil ->
          @default_template
        path ->
          File.read!(path)
      end

    default_md =
      Earmark.as_html!(default_template)

    {:ok, assign(socket, user_md: default_template, md_html: default_md)}
  end

  def handle_event("render", %{"user_md" => user_md}, socket) do
    md_html =
      case Earmark.as_html(user_md) do
        {_, html_doc, _} ->
          html_doc
    end

    {:noreply, assign(socket, user_md: user_md, md_html: md_html)}
  end

  # TODO: listen for tab while in the text area and insert spaces
  # TODO: download button

end
