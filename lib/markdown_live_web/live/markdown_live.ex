defmodule MarkdownLiveWeb.MarkdownLive do
  use Phoenix.LiveView
  alias MarkdownLiveWeb.MarkdownView

  def render(assigns) do
    MarkdownView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    default_template = 
      File.read!(System.get_env("DEFAULT_MD"))
    
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