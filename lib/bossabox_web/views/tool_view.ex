defmodule BossaboxWeb.ToolView do
  use BossaboxWeb, :view

  def render("create.json", %{tool: tool}) do
    %{
      message: "Tool Created",
      tool: tool
    }
  end

  def render("update.json", %{tool: tool}) do
    %{
      message: "Tool Updated",
      tool: tool
    }
  end

  def render("delete.json", _) do
    %{
      message: "Tool deleted with successful"
    }
  end
end
