defmodule PokepetWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PokepetWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PokepetWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PokepetWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, message}) when is_bitstring(message) do
    conn
    |> put_status(:method_not_allowed)
    |> put_view(PokepetWeb.ErrorView)
    |> render("error.json", message: message)
  end
end
