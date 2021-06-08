defmodule Bossabox.Tools.Delete do
  alias Bossabox.{Tool, Repo}

  def call(id) do
    Tool
    |> Repo.get(id)
    |> Repo.delete()
    |> handle_delete()
  end

  def handle_delete({:ok, _}), do: {:ok}
  def handle_delete(nil), do: {:error, %{status: :bad_request, message: "Ferramenta não existe"}}
end
