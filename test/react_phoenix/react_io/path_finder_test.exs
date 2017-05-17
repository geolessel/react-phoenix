defmodule ReactPhoenix.ReactIo.PathFinderTest do
  use ExUnit.Case
  import ReactPhoenix.ReactIo.PathFinder

  test "react_stdio_path returns the first existing file" do
    assert react_stdio_path(["test", "does_not_exist"]) == "test"
    assert react_stdio_path(["does_not_exist", "test"]) == "test"
  end

  test "react_stdio_path raises an error if no location is found" do
    assert_raise RuntimeError, fn -> react_stdio_path([]) end
  end
end
