defmodule SolarFlareRecorder do
  use GenServer
  
  def start_link do
    {:ok, pid} = connect
    GenServer.start_link(__MODULE__,%{pid: pid})
  end
  
  def record(pid, flare) do
    GenServer.cast(pid, {:new, flare})
  end
  
  def current(pid) do
    GenServer.call(pid, :load)
  end
  
  def handle_call(:load, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:new, flare}, state) do
    add_flare(flare, state)
    {:noreply, state}
  end
  
  defp add_flare(flare, state) do
    """
    insert into solar_flares(classification, scale, date, index)
    values($1, $2, now(), $3) RETURNING *;
    """
    |> execute(state, [Atom.to_string(flare.classification), flare.scale, flare.index])
  end

  defp get_flares do
    """
    select * from solar_flares;
    """
    |> execute
  end
  
  defp execute(sql, state, params \\ []) do
    Postgrex.Connection.query!(state.pid, sql, params) |> transform_result    
  end

  defp connect do
    Postgrex.Connection.start_link(hostname: "localhost", database: "redfour", username: "postgres", password: "postgres")
  end

  defp transform_result(result) do
    atomized = for col <- result.columns, do: String.to_atom(col)
    for row <- result.rows, do: List.zip([atomized, row]) |> Enum.into(%{})
  end
  
  def terminate(reason, state) do
    Postgrex.Connection.stop(state.pid) #release on termination
  end
  
end