defmodule BossaboxWeb.ToolControllerTest do
  use BossaboxWeb.ConnCase
  use ExUnit.Case
  alias Bossabox.{Repo, Tool}

  describe "create/2" do
    test "when params are valid, creates a tool", %{conn: conn} do
      params = %{
        title: "Notion",
        link: "https://www.notion.so/",
        description:
          "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized.",
        tags: ["Organization"]
      }

      response =
        conn
        |> post(Routes.tool_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "title" => "Notion",
               "link" => "https://www.notion.so/",
               "description" =>
                 "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized.",
               "tags" => ["Organization"],
               "id" => _id,
               "updated_at" => _updated,
               "inserted_at" => _inserted
             } = response
    end

    test "when params are invalid, notify required fields", %{conn: conn} do
      params = %{
        titl: "Notion",
        lin: "https://www.notion.so/",
        descriptio:
          "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized.",
        tag: ["Organization"]
      }

      response =
        conn
        |> post(Routes.tool_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "title" => ["can't be blank"],
                 "link" => ["can't be blank"],
                 "description" => ["can't be blank"],
                 "tags" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "index/1" do
    setup %{conn: conn} do
      {:ok, %Tool{} = tool1} =
        Repo.insert(%Tool{
          description: "notion",
          link: "no Link",
          tags: ["teste"],
          title: "teste"
        })

      {:ok, %Tool{} = tool2} =
        Repo.insert(%Tool{
          description: "notion2",
          link: "no Link2",
          tags: ["teste2"],
          title: "teste2"
        })

      {:ok, conn: conn, list: [tool1, tool2]}
    end

    test "show all created tools", %{conn: conn, list: list} do
      [
        %{
          id: id1,
          title: title1,
          description: desc1,
          tags: tags1
        },
        %{
          id: id2,
          title: title2,
          description: desc2,
          tags: tags2
        }
      ] = list

      response =
        conn
        |> get(Routes.tool_path(conn, :index))
        |> json_response(:ok)

      assert [
               %{
                 "id" => ^id1,
                 "title" => ^title1,
                 "description" => ^desc1,
                 "tags" => ^tags1
               },
               %{
                 "id" => ^id2,
                 "title" => ^title2,
                 "description" => ^desc2,
                 "tags" => ^tags2
               }
             ] = response
    end
  end

  describe "index/2" do
    setup %{conn: conn} do
      {:ok, %Tool{} = tool1} =
        Repo.insert(%Tool{
          description: "notion",
          link: "no Link",
          tags: ["teste"],
          title: "teste"
        })

      {:ok, %Tool{} = tool2} =
        Repo.insert(%Tool{
          description: "notion2",
          link: "no Link2",
          tags: ["teste2"],
          title: "teste2"
        })

      {:ok, conn: conn, list: [tool1, tool2]}
    end

    test "show created tools with tag \"teste\"", %{conn: conn, list: list} do
      [
        %Tool{
          id: id1,
          title: title1,
          description: desc1,
          tags: [tags1]
        },
        _
      ] = list

      response =
        conn
        |> get(Routes.tool_path(conn, :index, %{tag: tags1}))
        |> json_response(:ok)

      assert [
               %{
                 "id" => ^id1,
                 "title" => ^title1,
                 "description" => ^desc1,
                 "tags" => [^tags1]
               }
             ] = response
    end
  end

  describe "show/2" do
    setup %{conn: conn} do
      {:ok, %Tool{id: id}} =
        Repo.insert(%Tool{
          description: "notion",
          link: "no Link",
          tags: ["teste"],
          title: "teste"
        })

      {:ok, conn: conn, id: id}
    end

    test "when id is valid, return a tool", %{conn: conn, id: id} do
      response =
        conn
        |> get(Routes.tool_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "description" => "notion",
               "link" => "no Link",
               "tags" => ["teste"],
               "title" => "teste",
               "id" => ^id,
               "updated_at" => _updated,
               "inserted_at" => _inserted
             } = response
    end

    test "when id invalid, return an error", %{conn: conn, id: _id} do
      response =
        conn
        |> get(Routes.tool_path(conn, :show, "invalid Id"))
        |> json_response(:bad_request)

      assert %{
               "message" => "Id inválido"
             } = response
    end

    test "when id is unused, return an error", %{conn: conn, id: _id} do
      response =
        conn
        |> get(Routes.tool_path(conn, :show, Ecto.UUID.generate()))
        |> json_response(:bad_request)

      assert %{
               "message" => "Ferramenta não encontrada"
             } = response
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      {:ok, %Tool{id: id}} =
        Repo.insert(%Tool{
          description: "notion",
          link: "no Link",
          tags: ["teste"],
          title: "teste"
        })

      {:ok, conn: conn, id: id}
    end

    test "when id is valid, update and return a tool", %{conn: conn, id: id} do
      params = %{
        title: "Notion",
        link: "https://www.notion.so/",
        tags: ["Organization"]
      }

      response =
        conn
        |> put(Routes.tool_path(conn, :update, id, params))
        |> json_response(:ok)

      %{title: title, link: link, tags: tags} = params

      assert %{
               "description" => _description,
               "id" => ^id,
               "inserted_at" => _inserted,
               "link" => ^link,
               "tags" => ^tags,
               "title" => ^title,
               "updated_at" => _updated
             } = response
    end

    test "when id invalid, return an error", %{conn: conn, id: _id} do
      reponse =
        conn
        |> put(Routes.tool_path(conn, :update, "invalid Id", %{}))
        |> json_response(:bad_request)

      assert %{
               "message" => "Id inválido"
             } = reponse
    end

    test "when id is unused, return an error", %{conn: conn, id: _id} do
      reponse =
        conn
        |> put(Routes.tool_path(conn, :update, Ecto.UUID.generate(), %{}))
        |> json_response(:bad_request)

      assert %{
               "message" => "Ferramenta não encontrada"
             } = reponse
    end

    test "when an argument is invalid, return an error", %{conn: conn, id: id} do
      params = %{
        title: "Novo título",
        decription: "Description"
      }

      reponse =
        conn
        |> put(Routes.tool_path(conn, :update, id, params))
        |> json_response(:bad_request)

      assert %{
               "message" => "Campo decription inválido"
             } = reponse
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      {:ok, %Tool{id: id}} =
        Repo.insert(%Tool{
          description: "notion",
          link: "no Link",
          tags: ["teste"],
          title: "teste"
        })

      {:ok, conn: conn, id: id}
    end

    test "when id is valid, delete a tool", %{conn: conn, id: id} do
      conn
      |> delete(Routes.tool_path(conn, :delete, id))
      |> response(:no_content)
    end

    test "when id invalid, return an error", %{conn: conn, id: _id} do
      reponse =
        conn
        |> put(Routes.tool_path(conn, :update, "invalid Id", %{}))
        |> json_response(:bad_request)

      assert %{
               "message" => "Id inválido"
             } = reponse
    end

    test "when id is unused, return an error", %{conn: conn, id: _id} do
      reponse =
        conn
        |> put(Routes.tool_path(conn, :update, Ecto.UUID.generate(), %{}))
        |> json_response(:bad_request)

      assert %{
               "message" => "Ferramenta não encontrada"
             } = reponse
    end
  end
end
