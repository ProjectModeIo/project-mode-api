require IEx
defmodule PmApi.Network do
  @moduledoc """
  The Network context.
  """

  import Ecto.Query, warn: false
  alias PmApi.Repo

  alias PmApi.Network.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end

  alias PmApi.Network.Teammember

  @doc """
  Returns the list of teammembers.

  ## Examples

      iex> list_teammembers()
      [%Teammember{}, ...]

  """
  def list_teammembers do
    Repo.all(Teammember)
  end

  @doc """
  Gets a single teammember.

  Raises `Ecto.NoResultsError` if the Teammember does not exist.

  ## Examples

      iex> get_teammember!(123)
      %Teammember{}

      iex> get_teammember!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teammember!(id), do: Repo.get!(Teammember, id)

  @doc """
  Creates a teammember.

  ## Examples

      iex> create_teammember(%{field: value})
      {:ok, %Teammember{}}

      iex> create_teammember(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teammember(attrs \\ %{}) do
    %Teammember{}
    |> Teammember.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teammember.

  ## Examples

      iex> update_teammember(teammember, %{field: new_value})
      {:ok, %Teammember{}}

      iex> update_teammember(teammember, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teammember(%Teammember{} = teammember, attrs) do
    teammember
    |> Teammember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Teammember.

  ## Examples

      iex> delete_teammember(teammember)
      {:ok, %Teammember{}}

      iex> delete_teammember(teammember)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teammember(%Teammember{} = teammember) do
    Repo.delete(teammember)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teammember changes.

  ## Examples

      iex> change_teammember(teammember)
      %Ecto.Changeset{source: %Teammember{}}

  """
  def change_teammember(%Teammember{} = teammember) do
    Teammember.changeset(teammember, %{})
  end

  alias PmApi.Network.Volunteer

  def list_volunteers do
    Repo.all(Volunteer)
  end

  def get_volunteer!(id), do: Repo.get!(Volunteer, id)

  def get_volunteer_by(params_obj) do
    Repo.get_by(Volunteer, params_obj)
  end

  def create_or_update_volunteer(params_obj) do
    # IEx.pry
    case Repo.get_by(Volunteer, params_obj) do
      %Volunteer{} = volunteer ->
        update_volunteer(volunteer, params_obj)
      _ ->
        create_volunteer(params_obj)
    end
  end

  def create_volunteer(attrs \\ %{}) do
    %Volunteer{}
    |> Volunteer.changeset(attrs)
    |> Repo.insert()
  end

  def update_volunteer(%Volunteer{} = volunteer, attrs) do
    volunteer
    |> Volunteer.changeset(attrs)
    |> Repo.update()
  end

  def delete_volunteer(%Volunteer{} = volunteer) do
    Repo.delete(volunteer)
  end

  def change_volunteer(%Volunteer{} = volunteer) do
    Volunteer.changeset(volunteer, %{})
  end
end
