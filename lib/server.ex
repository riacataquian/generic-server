defmodule Server do
  @moduledoc """
  This module is generic code that blindly forwards requests
  from client processes to the callback module.

  ## OTP naming conventions:
    * `call` - Synchronous Requests - The server process needs to
      respond with a state.
    * `cast` - Asynchronous Requests - Fire-and-forget requests.
  """

  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init
      loop(callback_module, initial_state)
    end)
  end

  def call(server_pid, request) do
    # Send the message
    send(server_pid, {:call, request, self})

    # Wait for the response
    receive do
      {:response, response} -> response # Return the response
    end
  end

  def cast(server_pid, request), do: send(server_pid, {:cast, request})

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        # Invokes the callback to handle the message.
        {response, new_state} = callback_module.handle_call(request, current_state)

        # Sends the response back.
        send(caller, {:response, response})

        # Loops with new state.
        loop(callback_module, new_state)

      {:cast, request} ->
        new_state = callback_module.handle_cast(request, current_state)

        # Loops with new state.
        loop(callback_module, new_state)
    end
  end
end
