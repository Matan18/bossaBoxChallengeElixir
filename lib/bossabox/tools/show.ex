defmodule Bossabox.Tools.Show do
  alias Bossabox.{Tool, Repo}

  def call(id) do
    Tool
    |> Repo.get(id)
    |> handle_get()
  rescue
    Ecto.Query.CastError ->
      {:error, %{status: :bad_request, result: "Id inválido"}}
  end

  def handle_get(%Tool{} = result), do: {:ok, result}

  def handle_get(nil),
    do: {:error, %{status: :bad_request, result: "Ferramenta não encontrada"}}
end
