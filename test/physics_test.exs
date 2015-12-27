defmodule PhysicsTest do
  use ExUnit.Case
  alias Physics.Rocketry
  
  doctest Physics

  test "convert to km" do
    assert Calcs.to_km(1000) == 1
  end

  test "rounded to nearest tenth 1" do
    assert Calcs.to_nearest_tenth(11.123) == 11.2
  end
  
  test "rounded to nearest tenth 2" do
    assert Calcs.to_nearest_tenth(11.192) == 11.2
  end

  test "earth escape velocity" do
    earth_ev = Rocketry.escape_velocity(:earth)
    assert earth_ev == 11.2
  end
  
  test "mars escape velocity" do
    mars_ev = Rocketry.escape_velocity(:mars)
    assert mars_ev == 5.1
  end
  
  test "moon escape velocity" do
    moon_ev = Rocketry.escape_velocity(:moon)
    assert moon_ev == 2.4
  end
  
  test "earth orbital acceleartion" do
   acc = Rocketry.orbital_acceleration(100)
   assert Float.ceil(acc, 2) == 9.52
  end
  
  test "orbital term" do
   t = Rocketry.orbital_term(250)
   IO.inspect(t)
   km = Rocketry.orbital_height(4)
   IO.inspect(km)
  end
end
