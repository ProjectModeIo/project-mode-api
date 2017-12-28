defmodule Github do
  use HTTPotion.Base

  def process_request_headers(headers) do
    Dict.put headers, :"User-Agent", System.get_inv("GITHUB_USER_AGENT")
  end
end
