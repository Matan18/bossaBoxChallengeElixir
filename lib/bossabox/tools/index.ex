defmodule Bossabox.Tools.Index do
  import Ecto.Query
  alias Bossabox.{Repo, Tool}

  def call(tags) do
    Tool
    |> where([t], ^tags in t.tags)
    |> order_by(:inserted_at)
    |> Repo.all()
  end

  def call do
    Tool
    |> order_by(:inserted_at)
    |> Repo.all()
  end
end

# alias Bossabox.{Tool, Repo}
# import Ecto.Query
# Repo.query(from t in Tool, where: t.id ==^"16241d95-ee3e-4982-a304-c3d05e23aab4", select: t)
