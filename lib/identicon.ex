defmodule Identicon do
    def generate_from(string) do
        hash_input(string)
    end

    def hash_input(input) do
        :crypto.hash(:md5, input) |> :binary.bin_to_list
    end
end
