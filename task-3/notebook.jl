### A Pluto.jl notebook ###
# v0.12.7

using Markdown
using InteractiveUtils

# ╔═╡ 7e174312-213e-11eb-2e32-51850be19b5c
md"## Pirma užduotis"

# ╔═╡ 24f2d84a-21ff-11eb-370f-6fa6cdfecf41
begin
	import FFTW: fft, ifft
	import Plots: plot, plot!, plotly
	plotly()
end

# ╔═╡ 66e7314e-2214-11eb-2206-1baa62910408
md"###### Eksponentės realių ir menamų skaičių grafikas:"

# ╔═╡ 0de31d22-213f-11eb-1501-3196babe3624
begin
	freq = 10
	t = 0:1/freq:10
	e(val) = @. cos(freq * val) + im * sin(freq * val)

	results = e(t)
	plot(t, results .|> real, label = "Real", width = 2)
	plot!(t, results .|> imag, label = "Imaginary", width = 2)
end

# ╔═╡ f8c0da06-213e-11eb-2e0f-c7cb72964b82
md"## Antra užduotis"

# ╔═╡ dfa26cec-27a6-11eb-23e8-7b9a1a065aa3
begin
	len = length(t)
	y1 = fill(1, len)
	y2 = repeat([fill(0, 4)..., fill(1, 5)...], len ÷ 9 + 1)[1:len]
	y3 = sin.(0.1t)
	y4 = repeat([1, -1], len ÷ 2 + 1)[1:len]
	y5 = @. sin(0.1t) + 3 * sin(0.3t)
	
	f1 = y1 |> fft
	f2 = y2 |> fft
	f3 = y3 |> fft
	f4 = y4 |> fft
	f5 = y5 |> fft
end

# ╔═╡ 4327a554-2214-11eb-344c-812864f27ab9
md"###### Mūsu 5 signalai (originalūs signalai buvo vaizduojami atskirai dėl aiškumo):"

# ╔═╡ 0ea699fa-213f-11eb-128b-8b1efe7a92d1
plot(t, y1, label = "x1", width = 2)

# ╔═╡ 658628e8-27a3-11eb-07ff-4921747c7ec2
plot(t, y2, label = "x2", width = 2)

# ╔═╡ 67361cde-27a3-11eb-1547-6d676a81fb2d
plot(t, y3, label = "x3", width = 2)

# ╔═╡ 680c1110-27a3-11eb-2216-8d04324b8768
plot(t, y4, label = "x4", width = 2)

# ╔═╡ 69fad400-27a3-11eb-1a27-9f7d118693df
plot(t, y5, label = "x5", width = 2)

# ╔═╡ 392a0128-2214-11eb-0f9f-d776a2872c4d
md"###### Spektrai:"

# ╔═╡ 2f1d849e-220e-11eb-05bf-f7d1b43bfb5e
begin
	plot(t, f1 .|> abs, label = "abs(fft(x1))", width = 2)
	plot!(t, f2 .|> abs, label = "abs(fft(x2))", width = 2)
	plot!(t, f3 .|> abs, label = "abs(fft(x3))", width = 2)
	plot!(t, f4 .|> abs, label = "abs(fft(x4))", width = 2)
	plot!(t, f5 .|> abs, label = "abs(fft(x5))", width = 2)
end

# ╔═╡ 2827022c-2214-11eb-1611-49c4468e49b8
md"###### Fazės kreivės:"

# ╔═╡ 529f50cc-220f-11eb-10a7-c1a272ba950a
begin
	plot(t, f1 .|> angle, label = "angle(fft(x1))", width = 2)
	plot!(t, f2 .|> angle, label = "angle(fft(x2))", width = 2)
	plot!(t, f3 .|> angle, label = "angle(fft(x3))", width = 2)
	plot!(t, f4 .|> angle, label = "angle(fft(x4))", width = 2)
	plot!(t, f5 .|> angle, label = "angle(fft(x5))", width = 2)
end

# ╔═╡ f9eaea70-213e-11eb-0145-43bae4143e68
md"
## Trečia užduotis

Įvykdę advirkštinę Furje transformaciją gauname savo pradžioje turėtus signalus.
"

# ╔═╡ 0f79d518-213f-11eb-3645-17784899bb8b
begin
	plot(t, f1 |> ifft .|> real, label = "x1", width = 2)
	plot!(t, f2 |> ifft .|> real, label = "x2", width = 2)
	plot!(t, f3 |> ifft .|> real, label = "x3", width = 2)
	plot!(t, f4 |> ifft .|> real, label = "x4", width = 2)
	plot!(t, f5 |> ifft .|> real, label = "x5", width = 2)
end

# ╔═╡ 1a2f1e50-213f-11eb-339f-1f08bd402f79
md"
## Ketvirta užduotis

Pakeitus dalį koeficientų į nulius singalas nėra idealiai besikartojantis. Kiekvieną periodą yra mažų skirtumų.
"

# ╔═╡ 22947ebe-213f-11eb-01ed-29428f7a0f6f
begin
	f5[50:69] = zeros(20)
	plot(t, f5 |> ifft .|> real, label = "x3", width = 2)
end

# ╔═╡ f3456a8c-2211-11eb-3131-bda8467880ad
md"## Išvados"

# ╔═╡ 4f922410-2212-11eb-2e3a-278b7c9fee9f
md"
Furjė transformacija yra mums geriausias žinomas būdas atskirti skirtingo dažnio signalus.
"

# ╔═╡ Cell order:
# ╟─7e174312-213e-11eb-2e32-51850be19b5c
# ╠═24f2d84a-21ff-11eb-370f-6fa6cdfecf41
# ╟─66e7314e-2214-11eb-2206-1baa62910408
# ╠═0de31d22-213f-11eb-1501-3196babe3624
# ╟─f8c0da06-213e-11eb-2e0f-c7cb72964b82
# ╠═dfa26cec-27a6-11eb-23e8-7b9a1a065aa3
# ╟─4327a554-2214-11eb-344c-812864f27ab9
# ╠═0ea699fa-213f-11eb-128b-8b1efe7a92d1
# ╠═658628e8-27a3-11eb-07ff-4921747c7ec2
# ╠═67361cde-27a3-11eb-1547-6d676a81fb2d
# ╠═680c1110-27a3-11eb-2216-8d04324b8768
# ╠═69fad400-27a3-11eb-1a27-9f7d118693df
# ╟─392a0128-2214-11eb-0f9f-d776a2872c4d
# ╠═2f1d849e-220e-11eb-05bf-f7d1b43bfb5e
# ╟─2827022c-2214-11eb-1611-49c4468e49b8
# ╠═529f50cc-220f-11eb-10a7-c1a272ba950a
# ╟─f9eaea70-213e-11eb-0145-43bae4143e68
# ╠═0f79d518-213f-11eb-3645-17784899bb8b
# ╟─1a2f1e50-213f-11eb-339f-1f08bd402f79
# ╠═22947ebe-213f-11eb-01ed-29428f7a0f6f
# ╟─f3456a8c-2211-11eb-3131-bda8467880ad
# ╟─4f922410-2212-11eb-2e3a-278b7c9fee9f
