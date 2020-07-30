defmodule PhxHello.Campaign.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :story, :string
    field :title, :string
    belongs_to :user, PhxHello.Account.User

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :story])
    |> validate_required([:title, :story])
  end
end
