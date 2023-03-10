defmodule EmployeeRewardApp.Users do
  @moduledoc """
  The Users context.
  """

  use Timex

  import Ecto.Query, warn: false

  alias EmployeeRewardApp.Repo
  alias EmployeeRewardApp.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_fields(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end


  def rewards_summary(month) do
    start_date = Timex.parse!(month, "{YYYY}-{0M}")
    {:ok, end_date} = Date.end_of_month(start_date) |> NaiveDateTime.new(~T[23:59:59])

    Repo.all(
      from u in User,
        join: r in assoc(u, :given_to),
        group_by: u.id,
        select: %{user: u, summary: sum(r.amount)},
        where: r.inserted_at >= ^start_date and r.inserted_at <= ^end_date
    )
    # Descending sort by sum of rewards
    |> Enum.sort(fn(a,b) -> a.summary - b.summary >= 0 end)
  end


  def grant_monthly_points() do
    %{day: day} = Timex.now(Timex.Timezone.Local.lookup)
    case day do
      1 -> Repo.update_all(from(m in User, where: m.role == "user", update: [set: [points: 50]]),[])
      _ -> :ok
    end
  end
end
