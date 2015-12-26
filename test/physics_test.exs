defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "the truth" do
    assert 1 + 1 == 2
    "the Force may be with " <> somebody = "the Force may be with you"
    IO.inspect somebody
    assert somebody == "you"
  end
end
