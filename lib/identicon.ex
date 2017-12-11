defmodule Identicon do
    def generate_from(string) do
        hash_input(string) 
        |> pick_color
        |> build_grid
        |> remove_odd_squares
    end

    def hash_input(input) do
        hex = :crypto.hash(:md5, input) |> :binary.bin_to_list

        %Identicon.Image{hex: hex}
    end

    def pick_color(image) do
        %Identicon.Image{hex: [red, green, blue | _]} = image

        %Identicon.Image{image | color: {red, green, blue}}  
    end

    def build_grid(image) do
        grid = image.hex
            |> Enum.chunk(3)
            |> Enum.map(&mirror_row/1)
            |> List.flatten
            |> Enum.with_index

        %Identicon.Image{image | grid: grid}
    end

    def mirror_row(hex_row) do
        [first, second, _] = hex_row

        hex_row ++ [ second, first ]
    end

    def remove_odd_squares(image) do
        %Identicon.Image{grid: grid} = image

        grid = Enum.filter(grid, fn({code, _}) -> 
            rem(code, 2) === 0
        end)

        %Identicon.Image{image | grid: grid}
    end
end
