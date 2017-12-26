"""
def list_userinterests do
  userinterests = Repo.all(Userinterest)
  |> Repo.preload([:interest])
end

def update_userinterest(%Userinterest{} = userinterest, attrs) do
  userinterest
  |> Userinterest.changeset(attrs)
  |> Repo.update()
end

def change_userinterest(%Userinterest{} = userinterest) do
  Userinterest.changeset(userinterest, %{})
end

def list_userskills do
  users = Repo.all(Userskill)
  |> Repo.preload([:skill])
end

def update_userskill(%Userskill{} = userskill, attrs) do
  userskill
  |> Userskill.changeset(attrs)
  |> Repo.update()
end

def change_userskill(%Userskill{} = userskill) do
  Userskill.changeset(userskill, %{})
end

def list_userroles do
  userroles = Repo.all(Userrole)
  |> Repo.preload([:role])
end

def update_userrole(%Userrole{} = userrole, attrs) do
  userrole
  |> Userrole.changeset(attrs)
  |> Repo.update()
end


def change_userrole(%Userrole{} = userrole) do
  Userrole.changeset(userrole, %{})
end
"""
