defmodule Bossabox.Tools.Delete do
  alias Bossabox.{Repo, Tool}

  def call(id) do
    get_tool(id)
    |> handle_get()
    |> handle_delete()
  rescue
    Ecto.Query.CastError -> {:error, %{status: :bad_request, result: "Id inválido"}}
  end

  defp get_tool(id) do
    Tool
    |> Repo.get(id)
  end

  defp handle_get(%Tool{} = tool) do
    tool
    |> Repo.delete()
  end

  defp handle_get(nil),
    do: {:error, %{result: "Ferramenta não encontrada"}}

  def handle_delete({:ok, _}), do: {:ok}

  def handle_delete({:error, %{result: result}}),
    do: {:error, %{status: :bad_request, result: result}}
end
