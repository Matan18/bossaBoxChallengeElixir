defmodule BossaboxWeb.ToolController do
  use BossaboxWeb, :controller

  alias Bossabox.{
    Tool,
    Tools.Show,
    Tools.Index,
    Tools.Create,
    Tools.Update,
    Tools.Delete
  }

  def index(conn, %{"tags" => tags}) do
    with tools <- Index.call(tags) do
      conn
      |> json(tools)
    end
  end

  def index(conn, _) do
    with tools <- Index.call() do
      conn
      |> json(tools)
    end
  end

  def create(conn, params) do
    with {:ok, %Tool{} = tool} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> json(tool)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Tool{} = tool} <- Update.call(params, id) do
      conn
      |> json(tool)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Tool{} = tool} <- Show.call(id) do
      conn
      |> put_status(:ok)
      |> json(tool)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok} <- Delete.call(id) do
      conn
      |> resp(:no_content, "")
      |> send_resp()
    end
  end
end
