defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir test"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> decode
  end 

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
  
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}})  do
    {:ok, body}    
  end
  def handle_response({_, %HTTPoison.Response{status_code: _, body: body}})  do
    {:error, body}    
  end

  def decode({result, ""}) do
    {result, []}
  end
  def decode({result, body}) do
    {result, :jsx.decode(body)}
  end
end