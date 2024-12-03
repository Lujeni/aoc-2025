defmodule AdventOfCode do
  def historian_hysteria() do
    {:ok, content} = File.read("historian_hysteria.txt")
    lines = String.split(content, "\n", trim: true)

    # Reduce the input into two lists: left_list and right_list
    {left_list, right_list} =
      Enum.reduce(lines, {[], []}, fn line, {left_list, right_list} ->
        # Split each line into two parts: left and right
        [left, right] = String.split(line, ~r/\s+/, trim: true)

        {
          left_list ++ [String.to_integer(left)],
          right_list ++ [String.to_integer(right)]
        }
      end)

    sorted_left = Enum.sort(left_list)
    sorted_right = Enum.sort(right_list)

    Enum.zip(sorted_left, sorted_right)
    |> Enum.reduce(0, fn {a, b}, acc ->
      acc + abs(a - b)
    end)
  end

  # reduce_while(enumerable, acc, fun)
  # Reduces enumerable until fun returns {:halt, term}.
  def is_asc(report) do
    Enum.reduce_while(report, true, fn
      x, true -> {:cont, x}
      x, prev when prev < x and x - prev <= 3 -> {:cont, x}
      _x, _ -> {:halt, false}
    end) !== false
  end

  def is_desc(report) do
    Enum.reduce_while(report, true, fn
      x, true -> {:cont, x}
      x, prev when prev > x and prev - x <= 3 -> {:cont, x}
      _x, _ -> {:halt, false}
    end) !== false
  end

  def red_nose_reports() do
    reports = [
     [7, 6, 4, 2, 1],
     [1, 2, 7, 8, 9],
     [9, 7, 6, 2, 1],
     [1, 3, 2, 4, 5],
     [8, 6, 4, 4, 1],
     [1, 3, 6, 7, 9],
    ]
    reports =
      File.read!("red_nose_reports.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
      end)

    safe_reports = Enum.reduce(reports, 0, fn report, acc ->
      if is_asc(report) or is_desc(report) do
        acc + 1
      else
        acc
      end
    end)
    IO.puts("Number of safe reports: #{safe_reports}")
  end
end

# total_distance = AdventOfCode.historian_hysteria()
# IO.puts("La distance totale est : #{total_distance}")
AdventOfCode.red_nose_reports()
