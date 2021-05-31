defmodule BossaboxWeb.PageController do
  use BossaboxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
