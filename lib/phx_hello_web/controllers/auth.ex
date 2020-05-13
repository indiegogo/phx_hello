defmodule PhxHelloWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias PhxHelloWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && PhxHello.Account.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end
end
