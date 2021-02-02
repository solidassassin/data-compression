### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ cb3b7f8c-1130-11eb-0f4c-f7e7f500551d
md"
## Pirma užduotis

Tiesiog vaizduojame prašomas funkcijas (nuo `0` iki `10`)
"

# ╔═╡ 914c9814-1129-11eb-0a1d-0f4a61816f64
begin
	import Plots: plotly, plot, plot!
	
	plotly()
end

# ╔═╡ 62303d30-112a-11eb-387e-7b020abdf3bd
t = 0:10

# ╔═╡ 1b0f4aa4-112a-11eb-2619-1f321a8a9331
begin
	plot(t, t .* 0.5 .|> sin, lab = "sin(0.5t)", linewidth = 2)
	plot!(t, t .|> sin, lab = "sin(t)", linewidth = 2)
	plot!(t, t .* 2 .|> sin, lab = "sin(2t)", linewidth = 2)
	plot!(t, t .* 3 .|> sin, lab = "sin(3t)", linewidth = 2)
	plot!(t, t .* 4 .|> sin, lab = "sin(4t)", linewidth = 2)
	plot!(t, t .* 5 .|> sin, lab = "sin(5t)", linewidth = 2)
end

# ╔═╡ 11d64a7a-117d-11eb-05ab-59c6dd5644b3
md"## Antra užduotis"

# ╔═╡ ff6401f0-1183-11eb-35c4-090742a709fb
begin
	ny = 2π/(1*2)

	regular = 0:10
	nyquist = 0:ny:10
	nyquist_p = 0:ny*1.1:10
	nyquist_m = 0:ny*0.9:10

	plot(regular, regular .|> sin, lab = "regular", linewidth = 2)
	plot!(nyquist, nyquist .|> sin, lab = "nyquist", linewidth = 2)
	plot!(nyquist_p, nyquist_p .|> sin, lab = "nyquist positive", linewidth = 2)
	plot!(nyquist_m, nyquist_m .|> sin, lab = "nyquist negative", linewidth = 2)
end

# ╔═╡ 383b06a6-1191-11eb-3656-396347f691d8
md"## Third task"

# ╔═╡ 5a393a78-1303-11eb-2dfb-d9045bb0fcab
begin
	delta = 2π/0.17
	t2 = 0:2:100
	nyquist_x = 0:delta:100
	y = nyquist_x .* 0.1 .|> sin
	y2 = nyquist .|> sin
	y3 = nyquist_m .|> sin
	final(coll) = [@. (coll[k] * sin(0.085 * (t2 - (k-1) * delta))) / (0.085 * (t2 - (k - 1) * delta)) for k=1:length(y)]
	plot(t2, final(y) |> sum, linewidth = 2)
	#plot!(t2, final(y2) |> sum, linewidth = 2)
	#plot!(t2, final(y3) |> sum, linewidth = 2)
end

# ╔═╡ 60dd82c4-1719-11eb-1566-a35dac19538a


# ╔═╡ Cell order:
# ╟─cb3b7f8c-1130-11eb-0f4c-f7e7f500551d
# ╠═914c9814-1129-11eb-0a1d-0f4a61816f64
# ╠═62303d30-112a-11eb-387e-7b020abdf3bd
# ╠═1b0f4aa4-112a-11eb-2619-1f321a8a9331
# ╠═11d64a7a-117d-11eb-05ab-59c6dd5644b3
# ╠═ff6401f0-1183-11eb-35c4-090742a709fb
# ╟─383b06a6-1191-11eb-3656-396347f691d8
# ╠═5a393a78-1303-11eb-2dfb-d9045bb0fcab
# ╠═60dd82c4-1719-11eb-1566-a35dac19538a
