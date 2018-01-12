defmodule PmApi.ChatTest do
  use PmApi.DataCase

  alias PmApi.Chat

  describe "messages" do
    alias PmApi.Chat.Message

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Chat.create_message(@valid_attrs)
      assert message.text == "some text"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Chat.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.text == "some updated text"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end

  describe "notifications" do
    alias PmApi.Chat.Notification

    @valid_attrs %{link: "some link", message: "some message", read_at: ~N[2010-04-17 14:00:00.000000], seen: true}
    @update_attrs %{link: "some updated link", message: "some updated message", read_at: ~N[2011-05-18 15:01:01.000000], seen: false}
    @invalid_attrs %{link: nil, message: nil, read_at: nil, seen: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Chat.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Chat.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Chat.create_notification(@valid_attrs)
      assert notification.link == "some link"
      assert notification.message == "some message"
      assert notification.read_at == ~N[2010-04-17 14:00:00.000000]
      assert notification.seen == true
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Chat.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.link == "some updated link"
      assert notification.message == "some updated message"
      assert notification.read_at == ~N[2011-05-18 15:01:01.000000]
      assert notification.seen == false
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_notification(notification, @invalid_attrs)
      assert notification == Chat.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Chat.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Chat.change_notification(notification)
    end
  end
end
