### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ b70e28ee-ecac-11ea-3eab-bb94d2a5f88e
begin
	using Images
end

# ╔═╡ 9d8ba780-ecc1-11ea-1fbb-4392bac7fdce
using Random

# ╔═╡ c821f5d2-ecc6-11ea-0332-eb5b88fa14e0
using Plots

# ╔═╡ f2b53280-ecad-11ea-33a4-55df2b3323c1
md"# Module I Images"

# ╔═╡ 25554a80-ecaf-11ea-0df7-e58678f00ff7
md"## How big is Xiaomi?"

# ╔═╡ ff4c3330-ecae-11ea-2bd4-9796b30402cb
xiaomi = load("xiaomi.JPG")

# ╔═╡ 304dabd0-ecaf-11ea-2765-498ae8015ed9
size(xiaomi)

# ╔═╡ 505f0d60-ecaf-11ea-2ec0-9fee86126aca
typeof(xiaomi)

# ╔═╡ 5647f610-ecaf-11ea-3401-277e41eddeac
RGB(0.4, 0.4, 1)

# ╔═╡ c2356070-ecc2-11ea-1775-3ddcb1420e6e
md"## Cropping"

# ╔═╡ 7579a600-ecaf-11ea-3319-abf5042b3260
begin
	(h, w) = size(xiaomi)
	head = xiaomi[(h ÷ 4):(2h ÷ 3), (w ÷ 10): (9w ÷ 10)]
	# '÷' -- integer division
end

# ╔═╡ 1a2a4b00-ecb0-11ea-1dfb-db361169ad3d
size(head)

# ╔═╡ cc8a55d2-ecc2-11ea-1998-5593f7dae7cb
md"## Using array concatenation"

# ╔═╡ 1f07b71e-ecb0-11ea-38e1-0f9ed34cce04
[
	head 					reverse(head, dims=2)
	reverse(head, dims=1)	reverse(reverse(head, dims=1), dims=2)
]

# ╔═╡ e90e71f2-ecc2-11ea-38a0-1b3419850308
md"## Extracting colors"

# ╔═╡ aa82dc80-ecb5-11ea-228e-f5db4359afd8
redify(color::RGB) = RGB(color.r, 0.0, 0.0)

# ╔═╡ b78eb480-ecb5-11ea-2fa1-2566a56f61a4
redify.(head)

# ╔═╡ f13f9cf0-ecc2-11ea-2dfe-a391398a69ce
md"## Accessing array elements to swap color channels"

# ╔═╡ 48703d60-ecc1-11ea-1818-9f770e9ddd78
swaprg(color::RGB) = RGB(color.g, color.r, color.b)

# ╔═╡ 6427bab0-ecc1-11ea-0572-139453c31ab6
swaprg.(head)

# ╔═╡ 37430b5e-ecc3-11ea-14ec-e9765b7457a3
typeof(head)

# ╔═╡ 545b7bf0-edfa-11ea-11ef-b3b187121c67
rand(3)

# ╔═╡ 792d8110-ecc1-11ea-02fa-5741a88a6634
function randswap(color::Array, seed_num=0)
	Random.seed!(seed_num)
	color_list = [:r, :g, :b]
	shuffle!(color_list)
	RGB.([getfield.(color, c) for c in color_list]...)
end

# ╔═╡ dee1ba80-ecc1-11ea-0924-d9eb0d58af49
randswap(head)

# ╔═╡ 28bd0490-ecc5-11ea-2c1e-5382931facf6
begin
a = (fill(randswap(head), 3,3))
for (i, elem) in enumerate(a)
	a[i] = randswap(head, i+1)
end
a
end

# ╔═╡ 31213b90-ecc7-11ea-3fda-21e0c6a181a2
xiaomi_grid_colorify =
[
randswap(head,1) randswap(head,2) randswap(head,3)
randswap(head,4) randswap(head,5) randswap(head,6)
randswap(head,7) randswap(head,8) randswap(head,9)
]

# ╔═╡ e5a90e10-edfa-11ea-044e-f53ac313d085
function colorify(color, seed_num=0)
	Random.seed!(seed_num)
	color_list = [:r, :g, :b]
	shuffle!(color_list)
	randlist = rand(3)
	RGB.([randlist[i]*getfield.(color, c) for (i,c) in enumerate(color_list)]...)
end

# ╔═╡ 2c9989b0-edfd-11ea-3f35-cff4b71fd4e6
xiaomi_grid =
[
colorify(head,1) colorify(head,2) colorify(head,3)
colorify(head,4) colorify(head,5) colorify(head,6)
colorify(head,7) colorify(head,8) colorify(head,9)
]

# ╔═╡ 122333e0-ecc9-11ea-121a-fbbe993d0bce
begin
plot(xiaomi_grid, axis=false, size=(1200*2, 800*2))
savefig("c:/users/m163524/Desktop/xiaomi_grid.png")
end

# ╔═╡ 69bc2c30-edfd-11ea-2c0a-79aefb83f22a
begin
plot(xiaomi_grid_colorify, axis=false, size=(1200*2, 800*2))
savefig("c:/users/m163524/Desktop/xiaomi_grid_colorify.png")
end

# ╔═╡ 7eab5d50-edfd-11ea-1332-5316f4ce0135
xiaomi_grid_colorify_reverse= 
[
	colorify(head,1) 					colorify(reverse(head, dims=2),2)
	colorify(reverse(head, dims=1),3)	colorify(reverse(reverse(head, dims=1), dims=2),4)
]

# ╔═╡ be211790-edfd-11ea-2cb1-c9ae03f36fad
begin
plot(xiaomi_grid_colorify_reverse, axis=false, size=(1200*2, 800*2))
savefig("c:/users/m163524/Desktop/xiaomi_grid_reverse.png")
end

# ╔═╡ Cell order:
# ╟─f2b53280-ecad-11ea-33a4-55df2b3323c1
# ╟─b70e28ee-ecac-11ea-3eab-bb94d2a5f88e
# ╟─25554a80-ecaf-11ea-0df7-e58678f00ff7
# ╠═ff4c3330-ecae-11ea-2bd4-9796b30402cb
# ╠═304dabd0-ecaf-11ea-2765-498ae8015ed9
# ╠═505f0d60-ecaf-11ea-2ec0-9fee86126aca
# ╠═5647f610-ecaf-11ea-3401-277e41eddeac
# ╟─c2356070-ecc2-11ea-1775-3ddcb1420e6e
# ╠═7579a600-ecaf-11ea-3319-abf5042b3260
# ╠═1a2a4b00-ecb0-11ea-1dfb-db361169ad3d
# ╟─cc8a55d2-ecc2-11ea-1998-5593f7dae7cb
# ╠═1f07b71e-ecb0-11ea-38e1-0f9ed34cce04
# ╟─e90e71f2-ecc2-11ea-38a0-1b3419850308
# ╠═aa82dc80-ecb5-11ea-228e-f5db4359afd8
# ╠═b78eb480-ecb5-11ea-2fa1-2566a56f61a4
# ╟─f13f9cf0-ecc2-11ea-2dfe-a391398a69ce
# ╠═48703d60-ecc1-11ea-1818-9f770e9ddd78
# ╠═6427bab0-ecc1-11ea-0572-139453c31ab6
# ╠═37430b5e-ecc3-11ea-14ec-e9765b7457a3
# ╠═545b7bf0-edfa-11ea-11ef-b3b187121c67
# ╠═792d8110-ecc1-11ea-02fa-5741a88a6634
# ╟─9d8ba780-ecc1-11ea-1fbb-4392bac7fdce
# ╠═dee1ba80-ecc1-11ea-0924-d9eb0d58af49
# ╠═28bd0490-ecc5-11ea-2c1e-5382931facf6
# ╟─c821f5d2-ecc6-11ea-0332-eb5b88fa14e0
# ╠═31213b90-ecc7-11ea-3fda-21e0c6a181a2
# ╠═122333e0-ecc9-11ea-121a-fbbe993d0bce
# ╠═e5a90e10-edfa-11ea-044e-f53ac313d085
# ╠═2c9989b0-edfd-11ea-3f35-cff4b71fd4e6
# ╠═69bc2c30-edfd-11ea-2c0a-79aefb83f22a
# ╠═7eab5d50-edfd-11ea-1332-5316f4ce0135
# ╠═be211790-edfd-11ea-2cb1-c9ae03f36fad
