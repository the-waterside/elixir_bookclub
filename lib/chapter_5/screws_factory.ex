defmodule Chapter5.ScrewsFactory do
  @moduledoc """
    Module for completing chapter 5 question 2. To run this in iEX, enter the
    following (results shown under the command):

    iex> metal_pieces = Enum.take(Stream.cycle(["-"]), 1000)
    ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-",
    "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-",
    "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-",
    "-", "-", ...]

    iex> Chapter5.ScrewsFactory.run(metal_pieces)
    "|o---|"
    "|o---|"
    "|o---|"
    "|o---|"
    ...
  """

  @doc """
    Leverage Stream.chunk_every/2 to lazily "grab chunks" of the 1,000 original
    elements and work on them in those subsets instead of all at once.

    See below for the original eager approach from the book using Enum, which
    can be uncommented and run after commenting this solution for comparison. I
    added the new pack_screws/1 so it's a 1-to-1 comparison, but if you run the
    "greedy" version you may want to grab a cup of coffee while it works.
  """
  def run(pieces) do
    pieces
    |> Stream.chunk_every(50)
    |> Stream.flat_map(&add_thread/1)
    |> Stream.chunk_every(100)
    |> Stream.flat_map(&add_head/1)
    |> Stream.chunk_every(30)
    |> Stream.flat_map(&pack_screws/1)
    |> Enum.each(&output/1)
  end

  defp add_thread(pieces) do
    Process.sleep(50)
    Enum.map(pieces, &(&1 <> "--"))
  end

  defp add_head(pieces) do
    Process.sleep(100)
    Enum.map(pieces, &("o" <> &1))
  end

  defp pack_screws(pieces) do
    Process.sleep(70)
    Enum.map(pieces, &("|" <> &1 <> "|"))
    # Using interpolation instead on the above -> Enum.map(pieces, &"|#{&1}|")
  end

  defp output(screw) do
    IO.inspect(screw)
  end

#    def run(pieces) do
#      pieces
#      |> Enum.map(&add_thread/1)
#      |> Enum.map(&add_head/1)
#      |> Enum.map(&pack_screws/1)
#      |> Enum.each(&output/1)
#    end
#
#    defp add_thread(piece) do
#      Process.sleep(50)
#      piece <> "--"
#    end
#
#    defp add_head(piece) do
#      Process.sleep(100)
#      "o" <> piece
#    end
#
#    defp pack_screws(piece) do
#      Process.sleep(70)
#      "|" <> piece <> "|"
#      # Using interpolation instead on the above -> Enum.map(pieces, &"|#{&1}|")
#    end
#
#    defp output(screw) do
#      IO.inspect(screw)
#    end
end
