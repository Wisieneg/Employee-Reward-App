defmodule EmployeeRewardAppWeb.RewardControllerTest do
  use EmployeeRewardAppWeb.ConnCase

  import EmployeeRewardApp.RewardsFixtures
  import EmployeeRewardApp.UsersFixtures
  alias EmployeeRewardApp.Rewards
  alias EmployeeRewardApp.Users

  @admin_create_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wisieneg", password: "testpassword", password_confirmation: "testpassword", role: "admin"}
  @user_create_attrs %{name: "Wojciech Wiśniewski", email: "wwisniewski@example.com", username: "wisieneg", password: "testpassword", password_confirmation: "testpassword"}
  @from_user_create_attrs %{name: "Jan Kowalski", email: "jk@example.com", username: "jkowalski", password: "testpassword", password_confirmation: "testpassword"}
  @to_user_create_attrs %{name: "Wojciech Wiśniewski", email: "wwww@example.com", username: "wisieneg2", password: "testpassword", password_confirmation: "testpassword"}

  @create_attrs %{amount: 42}
  @update_attrs %{amount: 43}
  @invalid_attrs %{amount: -1}

  describe "index" do
    test "lists all rewards", %{conn: conn} do
      conn = get_conn_admin_user(conn)
      conn = get(conn, Routes.admin_reward_path(conn, :index))
      assert html_response(conn, 200) =~ "Amount"
    end
  end

  describe "new reward" do
    test "renders form", %{conn: conn} do
      new_user = user_fixture(@to_user_create_attrs)
      conn =get_conn_user(conn)
      conn = get(conn, Routes.reward_path(conn, :new, new_user.id))
      assert html_response(conn, 200) =~ "New reward"
      assert html_response(conn, 200) =~ "<form"
    end
  end

  describe "create reward" do
    test "redirects to users when data is valid", %{conn: conn} do
      new_user = user_fixture(@to_user_create_attrs)
      conn = get_conn_user(conn)

      conn = post(conn, Routes.reward_path(conn, :create,%{"reward" => @create_attrs, "to_id" => new_user.id}))


      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      new_user = user_fixture(@to_user_create_attrs)
      conn = get_conn_user(conn)

      conn = post(conn, Routes.reward_path(conn, :create), %{reward: @invalid_attrs, to_id: new_user.id})
      assert html_response(conn, 200) =~ "Oops"
    end
  end

  defp get_conn_user_by_id(conn, user) do
    user = Users.get_user!(user.id)
    conn = Pow.Plug.assign_current_user(conn, user, [])
  end

  defp get_conn_admin_user(conn) do
    user = user_fixture(@admin_create_attrs)
    user = Users.get_user!(user.id)
    conn = Pow.Plug.assign_current_user(conn, user, [])
  end

  defp get_conn_user(conn) do
    user = user_fixture(@user_create_attrs)
    user = Users.get_user!(user.id)
    conn = Pow.Plug.assign_current_user(conn, user, [])
  end

end
