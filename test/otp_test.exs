defmodule OTPTest do
  use ExUnit.Case
  
  setup do
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "redfour", username: "postgres", password: "postgres")
    Postgrex.Connection.query!(pid, "delete from solar_flares;", [])
    Postgrex.Connection.stop(pid)
  end    
  
  #test "Inserting 100 flares asynchronously" do    
  #  res = Enum.map 1..10000, fn(n) ->
  #    {:ok, pid} = SolarFlareRecorder.start_link
  #    SolarFlareRecorder.record(pid, %{index: n, classification: :X, scale: 33})
  #  end
  #  :timer.sleep(1000)
  #  assert Helpers.check_flare_count == 100
  #end
  
  test "Using worker to run 10 recorders concurrently" do
    res = Enum.map 1..80, fn(n) ->
      spawn(SolarFlareWorker, :run, [20])
    end
    :timer.sleep(1000)
  end
end