defmodule PhxHelloWeb.ProjectController do
  use PhxHelloWeb, :controller

  alias PhxHello.Campaign
  alias PhxHello.Campaign.Project

  def index(conn, _params, _current_user) do
    projects = Campaign.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params, _current_user) do
    changeset = Campaign.change_project(%Project{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project_params}, current_user) do
    case Campaign.create_project(current_user, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_user) do
    project = Campaign.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}, _current_user) do
    project = Campaign.get_project!(id)
    changeset = Campaign.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}, _current_user) do
    project = Campaign.get_project!(id)

    case Campaign.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _current_user) do
    project = Campaign.get_project!(id)
    {:ok, _project} = Campaign.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
