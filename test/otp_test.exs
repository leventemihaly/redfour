defmodule OTPTest do
  use ExUnit.Case
  
  test "A simple spawn" do
    res = for n <- 1..10, do: spawn(fn() -> IO.inspect "HI" end)
    IO.inspect res
  end
  
  test "A Simple service" do
    {:ok, pid} = SolarFlareRecorder.start_link()
    SolarFlareRecorder.record(pid, %{classification: :M, scale: 22})
    SolarFlareRecorder.record(pid, %{classification: :X, scale: 33})
    res = SolarFlareRecorder.current(pid)
    IO.inspect res
  end
end