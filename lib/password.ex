defmodule Password do
  @uppercase_letters Enum.to_list(?A..?Z)
  @lowercase_letters Enum.to_list(?a..?z)
  @numbers Enum.to_list(?0..?9)
  @symbols ~c"!@#$%^&*()-_=+[]{}|;:,.<>?"

  @words [
    "apple", "banana", "cherry", "date", "elephant", "frog", "giraffe", "house", "ice", "jungle", "kite",
    "lion", "monkey", "night", "orange", "penguin", "queen", "rabbit", "snake", "tiger", "umbrella", "village",
    "wolf", "xylophone", "yacht", "zebra", "ant", "ball", "cat", "dog", "egg", "fish", "goat", "hat", "igloo",
    "jar", "key", "leaf", "moon", "nest", "owl", "pig", "quilt", "rat", "sun", "tree", "urn", "van", "web",
    "box", "yak", "zip", "air", "bus", "cow", "drum", "ear", "fan", "gem", "hill", "ink", "jug", "kid", "log",
    "mat", "net", "oak", "pan", "pot", "rat", "sip", "tap", "urn", "vet", "wig", "yak", "zoo", "arch", "belt",
    "clap", "dusk", "ease", "fizz", "glow", "hint", "idea", "jolt", "knob", "lamb", "moth", "numb", "opus",
    "peek", "quip", "ramp", "skip", "twig"
  ]

  def generate(opts \\ []) do
    opts = Enum.into(opts, %{
      type: :chars,
      min_length: 8,
      max_length: 16,
      uppercase: false,
      numbers: false,
      symbols: false,
      separator: "-"
    })

    case opts.type do
      :chars -> generate_chars(opts)
      :words -> generate_words(opts)
      _ -> {:error, "Unknown type"}
    end
  end

  defp generate_chars(opts) do
    length = Enum.random(opts.min_length..opts.max_length)

    charset =
      @lowercase_letters ++
        (if opts.uppercase, do: @uppercase_letters, else: []) ++
        (if opts.numbers, do: @numbers, else: []) ++
        (if opts.symbols, do: @symbols, else: [])

    1..length
    |> Enum.map(fn _ -> Enum.random(charset) end)
    |> to_string()
  end

  defp generate_words(opts) do
    count = Enum.random(opts.min_length..opts.max_length)

    words =
      1..count
      |> Enum.map(fn _ ->
        word = Enum.random(@words)
        if opts.uppercase, do: capitalize(word), else: word
      end)

    Enum.join(words, opts.separator)
  end

  defp capitalize(word) when is_binary(word) and byte_size(word) > 0 do
    {first, rest} = String.split_at(word, 1)
    String.upcase(first) <> rest
  end
end
