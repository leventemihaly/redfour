defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "convert to km" do
    assert Calcs.convert_to_km(1000) == 1
  end

  test "rounded to nearest tenth 1" do
    assert Calcs.rounded_to_nearest_tenth(11.123) == 11.2
  end
  
  test "rounded to nearest tenth 2" do
    assert Calcs.rounded_to_nearest_tenth(11.192) == 11.2
  end

  test "earth escape velocity" do
    earth_ev = Physics.Rocketry.escape_velocity(:earth)
    assert earth_ev == 11.2
  end
  
  
end
