defmodule BirdsAndTrees.PageController do
  use BirdsAndTrees.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
