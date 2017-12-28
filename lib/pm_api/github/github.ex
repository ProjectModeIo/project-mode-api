defmodule PmApi.Github do
  @moduledoc """
  The Github context.
  """

  import Ecto.Query, warn: false
  alias PmApi.Repo

  alias PmApi.Github.Account

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
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
    |> Repo.update()
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
    Repo.delete(account)
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

  alias PmApi.Github.Repo

  @doc """
  Returns the list of repos.

  ## Examples

      iex> list_repos()
      [%Repo{}, ...]

  """
  def list_repos do
    Repo.all(Repo)
  end

  @doc """
  Gets a single repo.

  Raises `Ecto.NoResultsError` if the Repo does not exist.

  ## Examples

      iex> get_repo!(123)
      %Repo{}

      iex> get_repo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repo!(id), do: Repo.get!(Repo, id)

  @doc """
  Creates a repo.

  ## Examples

      iex> create_repo(%{field: value})
      {:ok, %Repo{}}

      iex> create_repo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repo(attrs \\ %{}) do
    %Repo{}
    |> Repo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repo.

  ## Examples

      iex> update_repo(repo, %{field: new_value})
      {:ok, %Repo{}}

      iex> update_repo(repo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repo(%Repo{} = repo, attrs) do
    repo
    |> Repo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Repo.

  ## Examples

      iex> delete_repo(repo)
      {:ok, %Repo{}}

      iex> delete_repo(repo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repo(%Repo{} = repo) do
    Repo.delete(repo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repo changes.

  ## Examples

      iex> change_repo(repo)
      %Ecto.Changeset{source: %Repo{}}

  """
  def change_repo(%Repo{} = repo) do
    Repo.changeset(repo, %{})
  end
end
