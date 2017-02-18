defmodule Store do
  @server Server

  ## Interface
  def start, do: @server.start(__MODULE__)

  # Issues the PUT request as cast
  def put(pid, key, value), do: @server.cast(pid, {:put, key, value})

  # Issues the GET request as cast
  def get(pid, key), do: @server.call(pid, {:get, key})

  ## Callbacks
  def init, do: Map.new # Initial process state

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value) # Handles the PUT request
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state} # Handles the GET request
  end
end
