defmodule MarkdownLiveWeb.MarkdownLive do
  use Phoenix.LiveView
  alias MarkdownLiveWeb.MarkdownView

  def render(assigns) do
    MarkdownView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, user_md: "", md_html: "")}
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

end