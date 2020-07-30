defmodule PhxHello.CampaignTest do
  use PhxHello.DataCase

  alias PhxHello.Campaign

  describe "projects" do
    alias PhxHello.Campaign.Project

    @valid_attrs %{story: "some story", title: "some title"}
    @update_attrs %{story: "some updated story", title: "some updated title"}
    @invalid_attrs %{story: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Campaign.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Campaign.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Campaign.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Campaign.create_project(@valid_attrs)
      assert project.story == "some story"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Campaign.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Campaign.update_project(project, @update_attrs)
      assert project.story == "some updated story"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Campaign.update_project(project, @invalid_attrs)
      assert project == Campaign.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Campaign.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Campaign.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Campaign.change_project(project)
    end
  end
end
