### A Pluto.jl notebook ###
# v0.12.3

using Markdown
using InteractiveUtils

# ╔═╡ f8faeed8-fa94-11ea-1b8a-67bf1e492b35
md"
## First task
I selected 2 blocks of text. One is a **news** article and the second is **fiction**.
###### Just some needed imports:
"

# ╔═╡ 1ea55542-fa86-11ea-06e5-0109bc4f7d74
begin
	import StatsBase: countmap
	import Plots: plotly, bar, bar!, ColorTypes
	
	plotly()
end

# ╔═╡ 62054314-fa96-11ea-2f95-3dac8f8103b0
md"###### Function which will process `.txt` files:"

# ╔═╡ 52fce56e-fabb-11ea-351d-a9ded584b491
article(name) = open(f -> read(f, String) |> lowercase, name)

# ╔═╡ 6925ab84-fa87-11ea-21f9-638a3a32e4f2
begin
	fiction_str = article("fiction.txt")
	news_str = article("news.txt")
	fiction = fiction_str |> collect
	news = news_str |> collect
end

# ╔═╡ e97e93ac-fa93-11ea-043e-d18ec3f0028d
md"###### News char count will be in blue, fiction - red:"

# ╔═╡ e2d88532-fa91-11ea-08c4-f76156ecb937
begin
	t_blue = ColorTypes.RGBA(0, 0, 1, 0.5)
	t_red = ColorTypes.RGBA(1, 0, 0, 0.5)
	nothing
end

# ╔═╡ 8e7f2a72-fa96-11ea-259b-730a50b7b6c8
md"#### Displaying the occurences:"

# ╔═╡ 2a8c5a46-fa94-11ea-08ff-45879404ae22
md"
Char count with only the **first half of the text**. As we can see it's almost identical (keep in mind that the news article is a bit longer).
"

# ╔═╡ db019be8-fa96-11ea-0aad-e5e203f12a22
begin
	bar(countmap(news[1:end÷2]), color=t_blue, label="News")
	bar!(countmap(fiction[1:end÷2]), color=t_red, label="Fiction")
end

# ╔═╡ db87515a-fa96-11ea-3a98-2f3f90f948ca
md"
Results are very similar comparing **full articles**.
"

# ╔═╡ 4d653122-fa86-11ea-3fd9-bd97c87425e0
begin
	bar(countmap(news), color=t_blue, label="News")
	bar!(countmap(fiction), color=t_red, label="Fiction")
end

# ╔═╡ 892f86d2-fab9-11ea-2f7f-a9340954c34e
md"
### Results:

In both cases the probability for the same chars to occur is almost identical.
"

# ╔═╡ 298976e4-faba-11ea-2916-092a30212298
md"
## Second task
### Results:
Identifying what type of text we're dealing with purely by char occurence count is very difficult or imposible. In this case the fictional text has more non-alphanumeral chars (probably from the dialogs that occur in in the text), but again most of the time any type of text can contain dialogs.
"

# ╔═╡ f36576d4-faba-11ea-0131-d33abc403b39
md"
## Third task

To calculate 0th order entropy we'll use this equation: $H = \sum_{i=1}^np_ilog_2\frac{1}{p_i}$
"

# ╔═╡ dc671a80-fac1-11ea-0c0a-b988200ef865
function entropy(text::Array{Char})
	len = length(text)
	processed = (text |> countmap |> values) ./ len
	[i*log2(1/i) for i=processed] |> sum
end

# ╔═╡ 68c5fef8-fac5-11ea-1ecc-73a086883e42
md"###### Fiction text entropy:"

# ╔═╡ df7229cc-fac4-11ea-1b4c-7fd0d38b48a5
entropy(fiction)

# ╔═╡ 7b0eea84-fac5-11ea-0f84-5f08c058807f
md"###### News text entropy:"

# ╔═╡ ad7e28b8-fac5-11ea-2d3d-5127ad845e55
entropy(news)

# ╔═╡ dac7edcc-fac5-11ea-0338-b5be77eb36dc
md"
### Results:
The difference between both entropies is `0.1` bit. This difference is insignificant and we can say the the entropy is about the same.
"

# ╔═╡ a6e0df36-fac6-11ea-2937-7fcaea25402c
md"
## Fourth task
We have to calculate each char pair entropy. For that we need each char and each char pair probability. We'll use this equation: $H(S) = \sum_{i=1}^np_i\sum_{j=1}^nlog_2\frac{1}{p_{ij}}$
"

# ╔═╡ 356c7422-fc32-11ea-115d-d703878a813d
import DataStructures: DefaultDict

# ╔═╡ a443c7ac-fc38-11ea-2db9-8b960e0e62cd
function pair_entropy(s::AbstractVector)
	counter = DefaultDict{Tuple{UInt8, UInt8}, Int}(0)
	@inbounds for i = 1:length(s)
		counter[(s[i], s[i + 1])] += 1
	end
	single_values = s |> countmap |> values
	single_total = single_values |> sum
	s_probabilities = single_values ./ single_total
	
	pair_values = counter |> values
	pair_total = pair_values |> sum
	p_probabilities = pair_values ./ pair_total
	
	[([i * log2(1 / i) for i=p_probabilities] |> sum) * x for x = s_probabilities] |> sum
end

# ╔═╡ 3f7dd5ce-0d45-11eb-214d-fd689300ed40
md"###### Fiction text entropy"

# ╔═╡ b7f3f9ae-fba0-11ea-0107-ed8f6b85b606
pair_entropy(codeunits(fiction_str))

# ╔═╡ 4b7fbe16-fc4a-11ea-0ebc-b72b0e42bf24
md"###### News text entropy:"

# ╔═╡ c3df5e42-fba1-11ea-0928-a19292ac911d
pair_entropy(codeunits(news_str))

# ╔═╡ a3697194-fba2-11ea-1397-3fe7c0744c81
md"
### Results:
`1st` order entropy is larger than `0th`. So modeling by `0th` order Markov model is insufficient.
"

# ╔═╡ Cell order:
# ╟─f8faeed8-fa94-11ea-1b8a-67bf1e492b35
# ╠═1ea55542-fa86-11ea-06e5-0109bc4f7d74
# ╠═62054314-fa96-11ea-2f95-3dac8f8103b0
# ╠═52fce56e-fabb-11ea-351d-a9ded584b491
# ╠═6925ab84-fa87-11ea-21f9-638a3a32e4f2
# ╠═e97e93ac-fa93-11ea-043e-d18ec3f0028d
# ╠═e2d88532-fa91-11ea-08c4-f76156ecb937
# ╟─8e7f2a72-fa96-11ea-259b-730a50b7b6c8
# ╟─2a8c5a46-fa94-11ea-08ff-45879404ae22
# ╠═db019be8-fa96-11ea-0aad-e5e203f12a22
# ╟─db87515a-fa96-11ea-3a98-2f3f90f948ca
# ╠═4d653122-fa86-11ea-3fd9-bd97c87425e0
# ╟─892f86d2-fab9-11ea-2f7f-a9340954c34e
# ╠═298976e4-faba-11ea-2916-092a30212298
# ╟─f36576d4-faba-11ea-0131-d33abc403b39
# ╠═dc671a80-fac1-11ea-0c0a-b988200ef865
# ╟─68c5fef8-fac5-11ea-1ecc-73a086883e42
# ╠═df7229cc-fac4-11ea-1b4c-7fd0d38b48a5
# ╟─7b0eea84-fac5-11ea-0f84-5f08c058807f
# ╠═ad7e28b8-fac5-11ea-2d3d-5127ad845e55
# ╠═dac7edcc-fac5-11ea-0338-b5be77eb36dc
# ╠═a6e0df36-fac6-11ea-2937-7fcaea25402c
# ╠═356c7422-fc32-11ea-115d-d703878a813d
# ╠═a443c7ac-fc38-11ea-2db9-8b960e0e62cd
# ╠═3f7dd5ce-0d45-11eb-214d-fd689300ed40
# ╠═b7f3f9ae-fba0-11ea-0107-ed8f6b85b606
# ╠═4b7fbe16-fc4a-11ea-0ebc-b72b0e42bf24
# ╠═c3df5e42-fba1-11ea-0928-a19292ac911d
# ╠═a3697194-fba2-11ea-1397-3fe7c0744c81
