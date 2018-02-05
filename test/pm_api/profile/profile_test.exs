defmodule PmApi.ProfileTest do
  use PmApi.DataCase

  alias PmApi.Profile

  describe "accounts" do
    alias PmApi.Profile.Account

    @valid_attrs %{commits_json: "some commits_json", organizations_json: "some organizations_json", projects_json: "some projects_json", totalcommits: 42, totalorganizations: 42, totalprojects: 42}
    @update_attrs %{commits_json: "some updated commits_json", organizations_json: "some updated organizations_json", projects_json: "some updated projects_json", totalcommits: 43, totalorganizations: 43, totalprojects: 43}
    @invalid_attrs %{commits_json: nil, organizations_json: nil, projects_json: nil, totalcommits: nil, totalorganizations: nil, totalprojects: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profile.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Profile.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Profile.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Profile.create_account(@valid_attrs)
      assert account.commits_json == "some commits_json"
      assert account.organizations_json == "some organizations_json"
      assert account.projects_json == "some projects_json"
      assert account.totalcommits == 42
      assert account.totalorganizations == 42
      assert account.totalprojects == 42
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profile.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, account} = Profile.update_account(account, @update_attrs)
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
      assert {:error, %Ecto.Changeset{}} = Profile.update_account(account, @invalid_attrs)
      assert account == Profile.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Profile.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Profile.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Profile.change_account(account)
    end
  end
end
