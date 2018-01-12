defmodule PmApi.NetworkTest do
  use PmApi.DataCase

  alias PmApi.Network

  describe "teams" do
    alias PmApi.Network.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Network.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Network.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Network.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Network.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Network.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, team} = Network.update_team(team, @update_attrs)
      assert %Team{} = team
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Network.update_team(team, @invalid_attrs)
      assert team == Network.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Network.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Network.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Network.change_team(team)
    end
  end

  describe "teammembers" do
    alias PmApi.Network.Teammember

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def teammember_fixture(attrs \\ %{}) do
      {:ok, teammember} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Network.create_teammember()

      teammember
    end

    test "list_teammembers/0 returns all teammembers" do
      teammember = teammember_fixture()
      assert Network.list_teammembers() == [teammember]
    end

    test "get_teammember!/1 returns the teammember with given id" do
      teammember = teammember_fixture()
      assert Network.get_teammember!(teammember.id) == teammember
    end

    test "create_teammember/1 with valid data creates a teammember" do
      assert {:ok, %Teammember{} = teammember} = Network.create_teammember(@valid_attrs)
    end

    test "create_teammember/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Network.create_teammember(@invalid_attrs)
    end

    test "update_teammember/2 with valid data updates the teammember" do
      teammember = teammember_fixture()
      assert {:ok, teammember} = Network.update_teammember(teammember, @update_attrs)
      assert %Teammember{} = teammember
    end

    test "update_teammember/2 with invalid data returns error changeset" do
      teammember = teammember_fixture()
      assert {:error, %Ecto.Changeset{}} = Network.update_teammember(teammember, @invalid_attrs)
      assert teammember == Network.get_teammember!(teammember.id)
    end

    test "delete_teammember/1 deletes the teammember" do
      teammember = teammember_fixture()
      assert {:ok, %Teammember{}} = Network.delete_teammember(teammember)
      assert_raise Ecto.NoResultsError, fn -> Network.get_teammember!(teammember.id) end
    end

    test "change_teammember/1 returns a teammember changeset" do
      teammember = teammember_fixture()
      assert %Ecto.Changeset{} = Network.change_teammember(teammember)
    end
  end

  describe "volunteers" do
    alias PmApi.Network.Volunteer

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def volunteer_fixture(attrs \\ %{}) do
      {:ok, volunteer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Network.create_volunteer()

      volunteer
    end

    test "list_volunteers/0 returns all volunteers" do
      volunteer = volunteer_fixture()
      assert Network.list_volunteers() == [volunteer]
    end

    test "get_volunteer!/1 returns the volunteer with given id" do
      volunteer = volunteer_fixture()
      assert Network.get_volunteer!(volunteer.id) == volunteer
    end

    test "create_volunteer/1 with valid data creates a volunteer" do
      assert {:ok, %Volunteer{} = volunteer} = Network.create_volunteer(@valid_attrs)
    end

    test "create_volunteer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Network.create_volunteer(@invalid_attrs)
    end

    test "update_volunteer/2 with valid data updates the volunteer" do
      volunteer = volunteer_fixture()
      assert {:ok, volunteer} = Network.update_volunteer(volunteer, @update_attrs)
      assert %Volunteer{} = volunteer
    end

    test "update_volunteer/2 with invalid data returns error changeset" do
      volunteer = volunteer_fixture()
      assert {:error, %Ecto.Changeset{}} = Network.update_volunteer(volunteer, @invalid_attrs)
      assert volunteer == Network.get_volunteer!(volunteer.id)
    end

    test "delete_volunteer/1 deletes the volunteer" do
      volunteer = volunteer_fixture()
      assert {:ok, %Volunteer{}} = Network.delete_volunteer(volunteer)
      assert_raise Ecto.NoResultsError, fn -> Network.get_volunteer!(volunteer.id) end
    end

    test "change_volunteer/1 returns a volunteer changeset" do
      volunteer = volunteer_fixture()
      assert %Ecto.Changeset{} = Network.change_volunteer(volunteer)
    end
  end
end
