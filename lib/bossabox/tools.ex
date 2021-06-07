defmodule Bossabox.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:link, :description, :tags]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :title]}

  schema "tools" do
    field :title, :string
    field :link, :string
    field :description, :string
    field :tags, {:array, :string}

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:title, :link, :description, :tags])
    |> validate_required([:link, :description, :tags])
  end
end
