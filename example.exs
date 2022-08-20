case Repo.insert(data) do
  {:ok, user} ->
    case Guardian.encode_and_sign(user, :token, claims) do
      {:ok, token, full_claims} ->
        important_stuff(token, full_claims)

      error ->
        error
    end

  error ->
    error
end

with {:ok, user} <- Repo.insert(changeset),
  {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims)
  do
    important_stuff(token, full_claims)
  end
