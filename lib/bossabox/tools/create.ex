defmodule Bossabox.Tools.Create do
  alias Bossabox.{Tool, Repo}

  def call(params) do
    params
    |> Tool.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def handle_insert({:ok, %Tool{}} = result), do: result
  def handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
