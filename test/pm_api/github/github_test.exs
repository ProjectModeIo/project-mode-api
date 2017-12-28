defmodule PmApi.GithubTest do
  use PmApi.DataCase

  alias PmApi.Github

  describe "accounts" do
    alias PmApi.Github.Account

    @valid_attrs %{commits_json: "some commits_json", organizations_json: "some organizations_json", projects_json: "some projects_json", totalcommits: 42, totalorganizations: 42, totalprojects: 42}
    @update_attrs %{commits_json: "some updated commits_json", organizations_json: "some updated organizations_json", projects_json: "some updated projects_json", totalcommits: 43, totalorganizations: 43, totalprojects: 43}
    @invalid_attrs %{commits_json: nil, organizations_json: nil, projects_json: nil, totalcommits: nil, totalorganizations: nil, totalprojects: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Github.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Github.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Github.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Github.create_account(@valid_attrs)
      assert account.commits_json == "some commits_json"
      assert account.organizations_json == "some organizations_json"
      assert account.projects_json == "some projects_json"
      assert account.totalcommits == 42
      assert account.totalorganizations == 42
      assert account.totalprojects == 42
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Github.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, account} = Github.update_account(account, @update_attrs)
      assert %Account{} = account
      assert account.commits_json == "some updated commits_json"
      assert account.organizations_json == "some updated organizations_json"
      assert account.projects_json == "some updated projects_json"
      assert account.totalcommits == 43
      assert account.totalorganizations == 43
      assert account.totalprojects == 43
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Github.update_account(account, @invalid_attrs)
      assert account == Github.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Github.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Github.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Github.change_account(account)
    end
  end

  describe "repos" do
    alias PmApi.Github.Repo

    @valid_attrs %{commits_json: "some commits_json", totalcommits: 42}
    @update_attrs %{commits_json: "some updated commits_json", totalcommits: 43}
    @invalid_attrs %{commits_json: nil, totalcommits: nil}

    def repo_fixture(attrs \\ %{}) do
      {:ok, repo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Github.create_repo()

      repo
    end

    test "list_repos/0 returns all repos" do
      repo = repo_fixture()
      assert Github.list_repos() == [repo]
    end

    test "get_repo!/1 returns the repo with given id" do
      repo = repo_fixture()
      assert Github.get_repo!(repo.id) == repo
    end

    test "create_repo/1 with valid data creates a repo" do
      assert {:ok, %Repo{} = repo} = Github.create_repo(@valid_attrs)
      assert repo.commits_json == "some commits_json"
      assert repo.totalcommits == 42
    end

    test "create_repo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Github.create_repo(@invalid_attrs)
    end

    test "update_repo/2 with valid data updates the repo" do
      repo = repo_fixture()
      assert {:ok, repo} = Github.update_repo(repo, @update_attrs)
      assert %Repo{} = repo
      assert repo.commits_json == "some updated commits_json"
      assert repo.totalcommits == 43
    end

    test "update_repo/2 with invalid data returns error changeset" do
      repo = repo_fixture()
      assert {:error, %Ecto.Changeset{}} = Github.update_repo(repo, @invalid_attrs)
      assert repo == Github.get_repo!(repo.id)
    end

    test "delete_repo/1 deletes the repo" do
      repo = repo_fixture()
      assert {:ok, %Repo{}} = Github.delete_repo(repo)
      assert_raise Ecto.NoResultsError, fn -> Github.get_repo!(repo.id) end
    end

    test "change_repo/1 returns a repo changeset" do
      repo = repo_fixture()
      assert %Ecto.Changeset{} = Github.change_repo(repo)
    end
  end
end
