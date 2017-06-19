defmodule ReactPhoenix.ReactIo.PathFinderTest do
  use ExUnit.Case
  import ReactPhoenix.ReactIo.PathFinder
  import ExUnit.CaptureLog

  test "react_stdio_path returns the first existing file" do
    assert react_stdio_path(["test", "does_not_exist"]) == "test"
    assert react_stdio_path(["does_not_exist", "test"]) == "test"
  end

  test "react_stdio_path returns nil if no location is found" do
    log_msg = capture_log(fn() ->
      assert react_stdio_path([]) == nil
    end)
    assert log_msg =~ "react-stdio cannot be found"
  end
end
