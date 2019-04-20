defmodule MarkdownLiveWeb.MarkdownLive do
  use Phoenix.LiveView
  alias MarkdownLiveWeb.MarkdownView
  alias MarkdownLiveWeb.Router.Helpers, as: Routes

  def render(assigns) do
    MarkdownView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    default_template = 
      File.read!("/Users/ndichev/Workspace/elixir-lab/markdown_live/assets/static/default_input/default.md")
    
    default_md = 
      Earmark.as_html!(default_template)

    {:ok, assign(socket, user_md: default_template, md_html: default_md)}
  end

  def handle_event("render", %{"user_md" => user_md}, socket) do
    md_html = 
      case Earmark.as_html(user_md) do
        {:ok, html_doc, []} ->
          html_doc    

        {:error, html_doc, error_messages} ->
          error_messages |> IO.inspect(label: "error messages:")
          html_doc
    end
    {:noreply, assign(socket, user_md: user_md, md_html: md_html)}
  end

  # TODO: listen for tab while in the text area and insert spaces
  # TODO: save button
  # TODO: download button

end