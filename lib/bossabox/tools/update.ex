defmodule Bossabox.Tools.Update do
  import Ecto.Changeset
  alias Bossabox.{Repo, Tool}

  def call(params, id) do
    params = translate_params(params)

    Tool
    |> Repo.get_by(id: id)
    |> handle_get(params)
    |> handle_update()
  rescue
    Ecto.Query.CastError ->
      {
        :error,
        %{status: :bad_request, result: "Id inválido"}
      }
  end

  defp handle_get(%Tool{} = tool, params) do
    tool
    |> change(params)
    |> Repo.update()
  rescue
    e in ArgumentError ->
      e
      |> handle_argument_error()
  end

  defp handle_get(nil, _),
    do: {:error, "Ferramenta não encontrada"}

  defp handle_argument_error(%{message: text}) do
    [_, message, _] =
      text
      |> String.split("`")

    field_name =
      message
      |> String.slice(1..-1)

    {:error, "Campo #{field_name} inválido"}
  end

  defp translate_params(params),
    do:
      for(
        {key, val} <- params,
        into: %{},
        do: {String.to_atom(key), val}
      )

  defp handle_update({:ok, %Tool{}} = tool), do: tool
  defp handle_update({:error, message}), do: {:error, %{result: message, status: :bad_request}}
end
