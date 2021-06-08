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
      |> put_status(:created)
      |> json(tools)
    end
  end

  def index(conn, _) do
    with tools <- Index.call() do
      conn
      |> put_status(:created)
      |> json(tools)
    end
  end

  def create(conn, params) do
    with {:ok, %Tool{} = tool} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", tool: tool)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Tool{} = tool} <- Update.call(params, id) do
      conn
      |> put_status(:created)
      |> render("update.json", tool: tool)
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
      |> put_status(:ok)
      |> render("delete.json")
    end
  end
end
