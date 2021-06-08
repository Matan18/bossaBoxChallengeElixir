defmodule Bossabox.Tools.Update do
  import Ecto.Changeset
  alias Bossabox.{Tool, Repo}

  def call(params, id) do
    params =
      for(
        {key, val} <-
          params,
        into: %{},
        do: {String.to_atom(key), val}
      )

    Tool
    |> Repo.get_by(id: id)
    |> change(params)
    |> Repo.update()
    |> handle_insert()
  end

  def handle_insert({:ok, %Tool{}} = result), do: result
  def handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
