defmodule PhxHelloWeb.SessionController do
  alias PhxHello.Account
  alias PhxHelloWeb.Auth
  use PhxHelloWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Account.authenticate_by_username_and_pass(username, password) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.user_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
