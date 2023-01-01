defmodule EmployeeRewardApp.Rewards do
  @moduledoc """
  The Rewards context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias EmployeeRewardApp.Repo
  alias EmployeeRewardApp.Users.User

  alias EmployeeRewardApp.Rewards.Reward

  @doc """
  Returns the list of rewards.

  ## Examples

      iex> list_rewards()
      [%Reward{}, ...]

  """
  def list_rewards do
    Repo.all(Reward)
  end

  @doc """
  Gets a single reward.

  Raises `Ecto.NoResultsError` if the Reward does not exist.

  ## Examples

      iex> get_reward!(123)
      %Reward{}

      iex> get_reward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward!(id), do: Repo.get!(Reward, id)


  def get_given_rewards(user_id) do
    Repo.all(
      from r in Reward,
        join: to_user in assoc(r, :to_user),
        where: r.from_id == ^user_id,
        preload: [to_user: to_user]
    )
  end

  def get_received_rewards(user_id) do
    Repo.all(
      from r in Reward,
        join: from_user in assoc(r, :from_user),
        where: r.to_id == ^user_id,
        preload: [from_user: from_user]
    )
  end

  @doc """
  Creates a reward.

  ## Examples

      iex> create_reward(%{field: value})
      {:ok, %Reward{}}

      iex> create_reward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward(%User{}=from_user, %User{}=to_user, attrs \\ %{}) do
    %Reward{}
    |> Reward.changeset(attrs)
    |> put_assoc(:from_user, from_user)
    |> put_assoc(:to_user, to_user)
    |> validate_number(:amount, greater_than: 0, less_than_or_equal_to: from_user.points)
    |> Repo.insert()
  end

  @doc """
  Updates a reward.

  ## Examples

      iex> update_reward(reward, %{field: new_value})
      {:ok, %Reward{}}

      iex> update_reward(reward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward.

  ## Examples

      iex> delete_reward(reward)
      {:ok, %Reward{}}

      iex> delete_reward(reward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward(%Reward{} = reward) do
    Repo.delete(reward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward changes.

  ## Examples

      iex> change_reward(reward)
      %Ecto.Changeset{data: %Reward{}}

  """
  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end
end
