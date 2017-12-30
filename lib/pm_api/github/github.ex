require IEx
defmodule PmApi.Github do
  @moduledoc """
  The Github context.
  """

  import Ecto.Query, warn: false
  alias PmApi.Repo

  alias PmApi.Github.Account

  def create_or_update_account(user, attrs \\ %{}) do
    case Repo.get_by(Account, %{user_id: user.id}) do
      %Account{} = account -> update_account(account, attrs)#update
      _ -> create_account(attrs) #create
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
