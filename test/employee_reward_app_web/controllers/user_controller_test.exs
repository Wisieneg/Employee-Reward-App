defmodule EmployeeRewardAppWeb.UserControllerTest do
  use EmployeeRewardAppWeb.ConnCase

  import EmployeeRewardApp.UsersFixtures

  @create_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wisieneg", password: "testpassword", password_confirmation: "testpassword"}
  @update_attrs %{current_password: "testpassword", password: "testpassword1", password_confirmation: "testpassword1"}
  @invalid_update_attrs %{current_password: "testpassword", password: "testpass", password_confirmation: "testpassword1"}
  @invalid_attrs %{name: "Jan Kowalski", email: "testowy@example.com", username: "t", password: "tstpassword", password_confirmation: "testpassword"}




  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get_conn_user(conn)
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ conn.assigns.current_user.name
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pow_registration_path(conn, :new))
      assert html_response(conn, 200) =~ "Register"
    end
  end

  describe "create user" do
    test "redirects to index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pow_registration_path(conn, :create), user: @create_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ @create_attrs.username
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pow_registration_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Register"
    end
  end

  describe "edit user" do
    test "renders form for editing chosen user", %{conn: conn} do
      conn = get_conn_user(conn)
      conn = get(conn, Routes.pow_registration_path(conn, :edit))
      assert html_response(conn, 200) =~ "Edit profile"
    end
  end


  describe "update user" do
    test "redirects when password is valid", %{conn: conn} do
      conn = get_conn_user(conn)
      conn = put(conn, Routes.pow_registration_path(conn, :update), user: @update_attrs)
      assert redirected_to(conn) == Routes.pow_registration_path(conn, :edit)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = get_conn_user(conn)
      conn = put(conn, Routes.pow_registration_path(conn, :update), user: @invalid_update_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below."
    end
  end

  describe "delete account" do

    test "deletes account and redirects to sign in page", %{conn: conn} do
      conn = get_conn_user(conn)
      conn = delete(conn, Routes.pow_registration_path(conn, :delete))
      assert redirected_to(conn) == Routes.pow_session_path(conn, :new)
    end
  end

  defp get_conn_user(conn) do
    user = user_fixture(@create_attrs)
    conn = Pow.Plug.assign_current_user(conn, user, [])
  end

end
