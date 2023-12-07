defmodule AlgostrixWeb.ErrorJSONTest do
  use AlgostrixWeb.ConnCase, async: true

  test "renders 404" do
    assert AlgostrixWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert AlgostrixWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
