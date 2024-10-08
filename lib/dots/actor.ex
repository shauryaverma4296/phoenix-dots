defmodule Dots.Actor do
  use GenServer
  alias Dots.Dot

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_opts) do
    x = :rand.uniform(700)
    y = :rand.uniform(600)
    hue = :rand.uniform(360)

    dot = %Dot{x: x, y: y, hue: hue, pid: self()}

    pid = GenServer.whereis(Dots.Canvas)

    Process.send(pid, {:new, dot}, [])

    {:ok, dot}
  end

  def handle_info(:move, old_dot) do
    IO.inspect(label: "Handle event 2 ")

    x = :rand.uniform(700)
    y = :rand.uniform(600)

    pid = GenServer.whereis(Dots.Canvas)

    new_dot = %Dot{old_dot | x: x, y: y}

    t = :rand.uniform(500) + 500

    Process.send(pid, {:move, new_dot}, [])
    # the below line will self broadcast with same data set after time t
    Process.send_after(self(), :move, t)

    {:noreply, new_dot}
  end
end
