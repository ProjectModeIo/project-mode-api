require IEx
defmodule PmApi.Profile do
  @moduledoc """
  The Profile context.
  """

  import Ecto.Query, warn: false
  alias PmApi.Repo
  alias PmApi.Projectmode.User
  alias PmApi.Profile.Account

  def update_avatar_photo(current_user, %{avatar_url: avatar_url}) do

  end

  def update_github_info(current_user, %{github_access_token: github_access_token, github_info: github_info}) do
    case Poison.encode(github_info) do
      {:ok, github_info_json} ->
        PmApi.Profile.create_or_update_account(current_user, %{
          user_id: current_user.id,
          access_token: github_access_token,
          avatar_url: github_info["avatar_url"],
          github_info_json: github_info_json
          })
      _ ->
        {:error, "Unable to read github info"}
    end
  end

  def create_or_update_account(user, attrs \\ %{}) do
    case Repo.get_by(Account, %{user_id: user.id}) do
      %Account{} = account -> update_account(account, attrs)#update
      _ -> create_account(Map.put(attrs, :user_id, user.id)) #create
    end
  end

  def list_accounts do
    PmApi.Repo.all(Account)
  end

  def get_account!(id), do: PmApi.Repo.get!(Account, id)

  def get_account_by(paramsObj) do
    Repo.get_by(Account, paramsObj)
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> PmApi.Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> PmApi.Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    PmApi.Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

end
