defmodule BookclubTest do
  use ExUnit.Case
  doctest Bookclub

  test "greets the world" do
    assert Bookclub.hello() == :world
  end
end
