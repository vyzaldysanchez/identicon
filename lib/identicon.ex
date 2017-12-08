defmodule Identicon do
    def generate_from(string) do
        hash_input(string) 
        |> pick_color
    end

    def hash_input(input) do
        hex = :crypto.hash(:md5, input) |> :binary.bin_to_list

        %Identicon.Image{hex: hex}
    end

    def pick_color(image) do
        %Identicon.Image{hex: [red, green, blue | _]} = image

        [red, green, blue]
    end
end
