defmodule Chucky.Server do
  use GenServer

  #api
  def start_link, do: GenServer.start_link(__MODULE__, [], [name: {:global, __MODULE__}])
  def fact, do: GenServer.call({:global, __MODULE__}, :fact)

  #server
  def init([]) do
    :random.seed(:os.timestamp)
    facts = "facts.txt" |> File.read! |> String.split("\n")

    {:ok, facts}
  end

  def handle_call(:fact, facts) do
    random_fact = facts |> Enum.shuffle |> List.first
    {:reply, random_fact, facts}
  end
end