--[[
	FROST UNIVERSAL  (Roblox / Luau, mobile + PC)
	Potato graphics, FPS boost, mesh hider, FPS + ping chips, player hider,
	nametag + character changer, and a fully restylable hub.

	Drag the header to move it. X hides the hub, tap the snowman to bring it back.
	On PC, RightShift also toggles it.
]]

------------------------------------------------------------
-- CONFIG (edit these)
------------------------------------------------------------
local CONFIG = {
	ParentToPlayerGui = false,   -- set true if you can't type in the boxes (keyboard won't open)
	ShowIntro = true,            -- icy intro on start (tap to skip)
	SliceBudget = 0.0015,        -- seconds of heavy work per frame (lower = smoother, slower to apply)
}

-- Optional overrides from a loader, so you never have to edit the hosted file:
--   getgenv().FrostUniversalConfig = { ShowIntro = false }
do
	local ok, env = pcall(function() return getgenv() end)
	if ok and type(env) == "table" then
		local o = env.FrostUniversalConfig or env.FrostHubzConfig or env.FrostBoostConfig
		if type(o) == "table" then
			for k, v in pairs(o) do CONFIG[k] = v end
		end
	end
end

-- tiny embedded snowman icon (3 KB). Optional: without writefile it falls back to an emoji.
local LOGO_B64 = [==[
/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUEBAQEAwUEBAQGBQUGCA0ICAcHCBALDAkNExAUExIQEhIUFx0ZFBYcFhISGiMaHB4f
ISEhFBkkJyQgJh0gISD/2wBDAQUGBggHCA8ICA8gFRIVICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICD/wAARCABYAFgDASIAAhEBAxEB/8QAHAAAAgEFAQAAAAAAAAAAAAAAAAcGAQIDBAUI/8QAOBAAAQMDAwIDBAgGAwEA
AAAAAQIDBAAFEQYHIRIxE0FRImFxgQgUFTJCkaGxI0NSYsHRF3Kywv/EABsBAAICAwEAAAAAAAAAAAAAAAUGAgQAAQMH/8QALxEA
AQQBAwIDBgcBAAAAAAAAAQACAxEEEiFBBTETImEGMlFxkZIVM4Gx0eHx8P/aAAwDAQACEQMRAD8Ad+MVVPejFXoTjJNOZOy82aVU
J8zQ642yyt55xDTSB1KWtQSlI9ST2rTu93t9is8m7XSQI8SOnqWs8/AAeZPYClinSu4W+DSJrSE6c0l1dUcSirMoZ++UDlf6J9M9
64ve1gtxpWIonzO0sFrbv+8lniPLhaaiLvspPBdSehhJ/wC34vlx76hMrX+4U9RcRd4tsSezceOFY+av90xT9GS7x4gTC1+2hxPI
bNrSG/h97NQPVG3e4WjGlyrraGrvb0cqm2vJ6B6qbPIoDk5WfICMMt/dx+4AfRem9C6b7Mxkfi3iFx5OzB9pJ/UlXae3fvlmvse2
6yfYnwZBwJbbYbca5xkgcKHr50/wQUgg5BGQfWvI2nptrl7k6cnSm2Z0JM1DTjbiepICuBkHzCiDz6V67UMKIPcVe6dkST44M3vi
weN0te2HSsXpnUzHg/lOaHN3sUfgfnawrHFYSrmsznANa5opwlCyqiiqUVsFaWYDNXhOBzVqR7fNZRz2qJWm/FLu5Wg7hb1WjQ8r
KrDamPta4tg8PnOG0H3cj5E01tR6h1vYNX2uBZdExp2llJQmVcPrqGTFGcH2CQAEpwfPPYVA9FSGrb9Jq8RZPsqu9laXHJ/EW1Dq
A+WT8qmlxl3dy13ONuNAYjQJF3RDtTlqUt1wtrV0tLdGPZOSM+XPYUvdSdLqd4YBIGwOwJTl0lsQhaXEgE7kKQXPXFlh6eul2gu/
aqrdHXIXGinLiwkc4B/es2jdSs600ZA1E3b3oTU5BUGH8EgAkd/MHGQfMVBrNH0Bpe7/AF9/WLD603D7HS2ogAS1DHgqxn2u/HAp
hWa7OTp92t6rPIt7dsfEdtbqQESE9AUFt4/Dzj5UGwXZToCcyMNffB4/1HcwY7ZwMWTUyuRyvN++G2FqsZe13puKmG9CfbfnRmhh
DzfUD1geSge+O4poQ5rFxt0e4xldTMlpLyD6hQyP3qm8kyKzt3qp2QoeEYK2RnzUodKR+ZFcTQ7D0XbvT7D4KXEQWuoHuPZz/mnL
HJdEC7v/AEkPqDgZKB2FgfK+FIFAEVgI91Z81jUQSashD6tWAe6iq4z2oqSxL2JulbrrH1JAYjvWq/2hiQsQZwAWroQohQHmOAcf
45qSbdXyZqbbew324KSqXMjBx5SE9IKskEgDt2pZ612q3A1w8iXdNQadjyo/UGHYkBxp0pwR0KcBz089jnFaOkN0WNBaFOir/aH4
upLGPqrMTBKZeVEpUFDy5+YxjvQxkknjaZNhx6ok6GF0Fw7usWO9D+L+iZG5MAR4MHWMG7MWm9WFwvRJDxwl31aI8+r0959alGi/
pA6K1FamPt6SmwXLpHiNSAfCUr+pC8Yxn1wR+tcnQu0c3UbjOsd2eqfPd/iRbMvhiGg8gLR5q/t7Dzyezqcs1oeioiu2uG5HbT0o
aUwgpSPQDGAKr5c8DjoIsjkbf6i2BiZMLbBAB4O6jiLntjcmypufpuSlUlM44cYOX08pdP8AeMD2u9X3rcDTFsiLX9twzgElYeSQ
Py5PyrK7t9oGYtS16RszigcEpiNjB9OBWeHoXSFuV4lu09Bhu+TjLKUqHwNU2OxwbdZ+iuysy3N0sLR67rzRftd2rcrXtt0rMkOW
rTTLglKXLbU0q6OJPsIHUB0oye57/HFOchKE9KUgJAwABjFWbiaDt2rrQqz3gEKTlcaWgZcZPqnPl6p7GkU1uJeNqm52jdasO3i4
xm0qtDjB6vraFEhKVHuACPPnuOeKMtnjDNRNBLMuLI5+hgs/BSZrcBUXcXWMS9XBmNYrOhlLZWAOlwgdXPdRPPFSjSmrrbrG3P3C
0sS0RmnfCDkhnww770+o/akLC213Gu1/e1lftKW64uz3DKVAmzSwEqPbqQn0HGCfjT+0qq+qsgRfrJDsz7SuhuNEeDiAgDgjAwPP
io4ssrz5xQ34/wCpSzIoYwNBs7XRFDbfbufmu6DRVKKI0hoJW3jPFLLTeloG6299+usxTjcDSbTcKG8yQFCX1FXie/pIUQDx2pmF
3pZL47BHWPyzXB+jFGH/ABZOuqxmRc7vJfcX5nBCR+x/OhuY4thJCK9JiEk9ngJ3tpUltKVL61AYKiMZPrWGdGM23SYYfcjl9pTY
daOFt5BHUk+ozkVsVy9RRbpN0vdIdlliHcnozjcZ8/y3CkhKvdzS8O6cXdioXtNtpI22tV0iyr6u7Oz5IeKigoSkAYBwSfaPcn4e
lMilfszpzX+m9OT4uu7iZLi5AVFaXI+sLaTj2sr9CeQM8c+tNCukpJebNrljgCIU2vRRTcEaiGiZz+krfHnXttIMZqQ50IyTgkk9
8DnHGcV5ivO1d405pSfuPe7u7dtdxHWrgp8Ky0wlCh1ISPMBJ79sDAAr2MsBTagexBBpeXaK1cLROgOgKbkR3WVD3KSR/mrWI0Od
bt6Q7qBLPd21d1H7Jdo990/Au0cjwpjKXhjyJHI+RyPlW4eKW+yMlyRtRDbcJJiyHmAT6BWf/qmMo0x1RpJrm04tVKKpRUjaxbOE
lvwj90p6fl2qP/RsmJjaV1BpB/2JlkuroUgnnoWfZOPilVd+lxcpcnbTdaNuJGjPO2G5oEO9JaQVeF26XePgD8QR+KqOVF4kRaO6
vdMyRDONXYr05XL1E/d4umLlJsEVuXdWo61xWXPuuOAeyDyPP31twJ8O529i4W+S3KiSEBxp5pXUlaT2INbNLXY7p7O42S52k1Fr
rUWnJr+u7KbbLZk+GyosFgvIxz7BPGDkZ7H5UxqKopSUpKlEADkk+VSe4OcSBShG0saATfqta4PiPb3nM89OB8TxS01NdW7JpG73
Z1QSmJEdcGfM9JwPzIqWXa5JmLDDJ/goOc/1H/VI7X8uTr7UMfbTTviPR0uJkXuUwOpLDSTnw8jzz+uB60Xw4tLfNyl/qEwe/wAv
YLNs9anbXtPaUvDpdldcog+i1ZH6AVOlCr2o7USK1EYaDTLKA2hsfgSBgD8hVijzii4Nm0tONm1ZRRRXRaUp0zFtMlClSlIckhXD
Th4A9QPOpY/ChyoLsGRGadivILbjSkgpWkjBBHmMUUUs51iYi05dKDTjg6QEmXNttd7fTnpm017ZftTqvEXp+6qJbSfPw1+X5g+p
NbLe72srSnw9XbQ36OtPCn7Z0ymj7xj/AGaKKhG7xTTxfryrErPAbqjJHpwsivpCaVQkhzTep23R+BdtIP8A6rkSt6Xb2rwrTofU
84H7raIfQn5kmiiirMWJg1AboPLlzSeUu2WhJa3W1agxGbW3o23OcOPOvByUpPoMfd+QB99TbQOl4e31odg2vpdckLDkh9xOVuqx
5nvjvx7z60UVF0mtuggUoMj0O8QE2pVJlW6Ywr7RjIbI/mpOCPh51C1Y61dJ6k54J8xRRVjEYGg0qWdIXuFqwnFFFFW3HdDwv//Z
]==]

------------------------------------------------------------
-- Services
------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer

local conns = {}
local cleanups = {}   -- functions run when the script is executed again
local onReady = {}    -- functions run once the hub is ready (after the intro)
local function track(c)
	conns[#conns + 1] = c
	return c
end

-- if the script is executed again (or the old Frost Boost is running), shut it down first
do
	local ok, env = pcall(function() return getgenv() end)
	if ok and type(env) == "table" then
		local ran = false
		for _, key in ipairs({ "FrostUniversalCleanup", "FrostHubzCleanup", "FrostBoostCleanup" }) do
			if type(env[key]) == "function" then
				pcall(env[key])
				ran = true
			end
		end
		if ran then task.wait(0.6) end
	end
end

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
local C = {
	ice = Color3.fromRGB(140, 220, 255),
	blue = Color3.fromRGB(40, 130, 235),
	green = Color3.fromRGB(70, 205, 150),
	red = Color3.fromRGB(235, 85, 105),
	gray = Color3.fromRGB(58, 74, 104),
	dark = Color3.fromRGB(8, 16, 32),
	panel = Color3.fromRGB(11, 22, 42),
	row = Color3.fromRGB(20, 40, 72),
	text = Color3.new(1, 1, 1),
	dim = Color3.fromRGB(165, 190, 222),
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

local function corner(inst, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r or 8) }, inst)
end

local B64CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function b64decode(data)
	data = data:gsub("[^%w%+/=]", "")
	local lut = {}
	for i = 1, 64 do lut[B64CHARS:byte(i)] = i - 1 end
	local out, n = {}, 0
	local byte, char = string.byte, string.char
	for i = 1, #data, 4 do
		local a, b, c, d = byte(data, i, i + 3)
		local v = lut[a] * 262144 + lut[b] * 4096 + (lut[c] or 0) * 64 + (lut[d] or 0)
		n += 1
		out[n] = char(v // 65536, (v // 256) % 256, v % 256)
	end
	local s = table.concat(out)
	if data:sub(-2) == "==" then
		s = s:sub(1, -3)
	elseif data:sub(-1) == "=" then
		s = s:sub(1, -2)
	end
	return s
end

-- writes the embedded file once, then returns a usable asset url (or nil)
local function loadAsset(fileName, b64)
	if not (writefile and getcustomasset) then return nil end
	local ok, asset = pcall(function()
		if not (isfile and isfile(fileName)) then
			writefile(fileName, b64decode(b64))
		end
		return getcustomasset(fileName)
	end)
	if ok then return asset end
	return nil
end

local function getParent()
	if CONFIG.ParentToPlayerGui then
		return player:WaitForChild("PlayerGui")
	end
	local ok, ui = pcall(function()
		return (gethui and gethui()) or game:GetService("CoreGui")
	end)
	if ok and ui then return ui end
	return player:WaitForChild("PlayerGui")
end

do
	local parent = getParent()
	for _, n in ipairs({ "FrostUniversal", "FrostHubz", "FrostBoostFPS" }) do
		local old = parent:FindFirstChild(n)
		if old then old:Destroy() end
	end
end

-- the snowman: used in the header, the reopen button and the intro
local logoAsset = loadAsset("frosthubz_logo_v1.jpg", LOGO_B64)
local function makeLogo(parent, size)
	if logoAsset then
		local img = new("ImageLabel", {
			Size = UDim2.fromOffset(size, size),
			BackgroundColor3 = C.panel,
			BorderSizePixel = 0,
			Image = logoAsset,
			ScaleType = Enum.ScaleType.Crop,
		}, parent)
		new("UICorner", { CornerRadius = UDim.new(1, 0) }, img)
		new("UIStroke", { Thickness = 1.5, Color = C.ice }, img)
		return img
	end
	return new("TextLabel", {
		Size = UDim2.fromOffset(size, size),
		BackgroundTransparency = 1,
		Text = "⛄",
		TextScaled = true,
		Font = Enum.Font.GothamBold,
		TextColor3 = C.text,
	}, parent)
end

------------------------------------------------------------
-- Window: header + side rail + content (landscape hub)
------------------------------------------------------------
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local cam = workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(800, 600)
local HEADER_H, RAIL_W = 40, 66
local W = math.clamp(vp.X - 40, 340, 470)
local H = math.clamp(vp.Y - 40, 230, 300)

local gui = new("ScreenGui", {
	Name = "FrostUniversal",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, nil)
gui.Parent = getParent()

local main = new("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(W, H),
	Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.05,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Active = true,
	Visible = false,
}, gui)
corner(main, 14)
new("UIGradient", {
	Color = ColorSequence.new(Color3.fromRGB(17, 36, 66), Color3.fromRGB(6, 13, 28)),
	Rotation = 90,
}, main)
local stroke = new("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), Transparency = 0.1 }, main)
local strokeGrad = new("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 220, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 130, 235)),
	}),
}, stroke)

-- frosty highlight along the top edge
local hl = new("Frame", {
	Size = UDim2.new(1, -40, 0, 1),
	Position = UDim2.fromOffset(20, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0,
}, main)
new("UIGradient", {
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.35),
		NumberSequenceKeypoint.new(1, 1),
	}),
}, hl)

-- header (drag handle)
local header = new("Frame", {
	Name = "Header",
	Size = UDim2.new(1, 0, 0, HEADER_H),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.55,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, main)

local hLogo = makeLogo(header, 28)
hLogo.Position = UDim2.fromOffset(10, 6)

local titleLbl = new("TextLabel", {
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(46, 4),
	Size = UDim2.fromOffset(140, 19),
	Font = Enum.Font.GothamBlack,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = Color3.new(1, 1, 1),
	Text = "Frost UNIVERSAL",
}, header)
local titleGrad = new("UIGradient", {
	Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(140, 220, 255)),
	Rotation = 90,
}, titleLbl)
new("TextLabel", {
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(46, 23),
	Size = UDim2.fromOffset(110, 12),
	Font = Enum.Font.Gotham,
	TextSize = 9,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.ice,
	TextTransparency = 0.15,
	Text = "OPTIMIZED BY FROST",
}, header)

local function chip(x, w)
	local f = new("TextLabel", {
		Size = UDim2.fromOffset(w, 20),
		Position = UDim2.new(1, x, 0.5, -10),
		BackgroundColor3 = C.dark,
		BackgroundTransparency = 0.3,
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = C.text,
		Text = "--",
	}, header)
	corner(f, 10)
	return f
end
local pingLabel = chip(-128, 60)
local fpsLabel = chip(-178, 46)
fpsLabel.Text = "-- fps"
pingLabel.Text = "-- ms"

local function headerButton(text, x)
	local b = new("TextButton", {
		Size = UDim2.fromOffset(26, 26),
		Position = UDim2.new(1, x, 0.5, -13),
		BackgroundColor3 = C.dark,
		BackgroundTransparency = 0.25,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = C.text,
	}, header)
	corner(b, 8)
	return b
end
local minBtn = headerButton("–", -64)
local closeBtn = headerButton("X", -34)

-- left rail
local rail = new("Frame", {
	Position = UDim2.fromOffset(8, HEADER_H + 8),
	Size = UDim2.new(0, RAIL_W, 1, -(HEADER_H + 16)),
	BackgroundColor3 = C.dark,
	BackgroundTransparency = 0.35,
	BorderSizePixel = 0,
}, main)
corner(rail, 10)
new("UIListLayout", {
	Padding = UDim.new(0, 3),
	SortOrder = Enum.SortOrder.LayoutOrder,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
}, rail)
new("UIPadding", { PaddingTop = UDim.new(0, 6) }, rail)

-- content
local CX = 8 + RAIL_W + 8
local content = new("Frame", {
	Position = UDim2.fromOffset(CX, HEADER_H + 8),
	Size = UDim2.new(1, -(CX + 8), 1, -(HEADER_H + 16)),
	BackgroundTransparency = 1,
}, main)

local pageTitle = new("TextLabel", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 20),
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.ice,
	Text = "",
}, content)
local divider = new("Frame", {
	Position = UDim2.fromOffset(0, 22),
	Size = UDim2.new(1, 0, 0, 1),
	BackgroundColor3 = C.ice,
	BorderSizePixel = 0,
}, content)
new("UIGradient", {
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	}),
}, divider)

local function makePage()
	local sf = new("ScrollingFrame", {
		Position = UDim2.fromOffset(0, 28),
		Size = UDim2.new(1, 0, 1, -50),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = C.ice,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Visible = false,
	}, content)
	new("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, sf)
	new("UIPadding", { PaddingRight = UDim.new(0, 6) }, sf)
	return sf
end
local pgBoost, pgPlayers, pgStyle, pgFonts, pgSettings = makePage(), makePage(), makePage(), makePage(), makePage()
local pages = { pgBoost, pgPlayers, pgStyle, pgFonts, pgSettings }
local TITLES = { "Boost", "Users", "Style", "Font Editor", "Settings" }
local NAMES = { "BOOST", "USERS", "STYLE", "FONTS", "SETTINGS" }

local statusLabel = new("TextLabel", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 1, -20),
	Size = UDim2.new(1, 0, 0, 18),
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.dim,
	TextTruncate = Enum.TextTruncate.AtEnd,
	Text = "Ready.",
}, content)
local function setStatus(t) statusLabel.Text = t end

-- navigation
local navBtns, navBars, current = {}, {}, 0
local function selectPage(i)
	if i == current then return end
	current = i
	for k, pg in ipairs(pages) do
		local on = (k == i)
		pg.Visible = on
		navBtns[k].BackgroundTransparency = on and 0.78 or 1
		navBtns[k].TextColor3 = on and C.text or C.dim
		navBars[k].Visible = on
	end
	pageTitle.Text = TITLES[i]
	local pg = pages[i]
	pg.Position = UDim2.fromOffset(12, 28)
	TweenService:Create(pg, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromOffset(0, 28),
	}):Play()
end
for i, name in ipairs(NAMES) do
	local b = new("TextButton", {
		LayoutOrder = i,
		Size = UDim2.new(1, -10, 0, 30),
		BackgroundColor3 = C.ice,
		BackgroundTransparency = 1,
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextScaled = true,
		TextColor3 = C.dim,
		AutoButtonColor = false,
	}, rail)
	corner(b, 8)
	new("UITextSizeConstraint", { MaxTextSize = 11, MinTextSize = 7 }, b)
	new("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 3) }, b)
	local bar = new("Frame", {
		Size = UDim2.new(0, 3, 0.6, 0),
		Position = UDim2.new(0, 0, 0.2, 0),
		BackgroundColor3 = C.ice,
		BorderSizePixel = 0,
		Visible = false,
	}, b)
	corner(bar, 2)
	navBtns[i], navBars[i] = b, bar
	b.MouseButton1Click:Connect(function() selectPage(i) end)
end

------------------------------------------------------------
-- Toast: small popup, ~2 seconds, with an icy accent bar + countdown line
------------------------------------------------------------
local toastCur = nil
local function showToast(text)
	if toastCur then
		pcall(function() toastCur:Destroy() end)
		toastCur = nil
	end
	text = tostring(text)
	local up = text:upper()
	local accent = C.ice
	if up:find("OFF", 1, true) then
		accent = C.red
	elseif up:find(": ON", 1, true) then
		accent = C.green
	end
	local inset = game:GetService("GuiService"):GetGuiInset()
	local card = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, inset.Y + 10),
		Size = UDim2.fromOffset(0, 34),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = C.panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 120,
	}, gui)
	corner(card, 9)
	local st = new("UIStroke", { Thickness = 1, Color = accent, Transparency = 1 }, card)
	local lbl = new("TextLabel", {
		Size = UDim2.fromOffset(0, 34),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = C.text,
		TextTransparency = 1,
		Text = text,
		ZIndex = 121,
	}, card)
	new("UIPadding", { PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 14) }, lbl)
	local bar = new("Frame", {
		Size = UDim2.new(0, 3, 0.6, 0),
		Position = UDim2.new(0, 7, 0.2, 0),
		BackgroundColor3 = accent,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 121,
	}, card)
	corner(bar, 2)
	local prog = new("Frame", {
		Size = UDim2.new(1, -16, 0, 2),
		Position = UDim2.new(0, 8, 1, -3),
		BackgroundColor3 = accent,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 121,
	}, card)
	toastCur = card

	local fi = TweenInfo.new(0.15)
	TweenService:Create(card, fi, { BackgroundTransparency = 0.08 }):Play()
	TweenService:Create(lbl, fi, { TextTransparency = 0 }):Play()
	TweenService:Create(st, fi, { Transparency = 0.45 }):Play()
	TweenService:Create(bar, fi, { BackgroundTransparency = 0 }):Play()
	TweenService:Create(prog, fi, { BackgroundTransparency = 0.2 }):Play()
	TweenService:Create(prog, TweenInfo.new(2, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 2) }):Play()

	task.delay(1.8, function()
		if toastCur ~= card then return end
		local fo = TweenInfo.new(0.2)
		TweenService:Create(card, fo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(lbl, fo, { TextTransparency = 1 }):Play()
		TweenService:Create(st, fo, { Transparency = 1 }):Play()
		TweenService:Create(bar, fo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(prog, fo, { BackgroundTransparency = 1 }):Play()
		task.wait(0.22)
		if toastCur == card then toastCur = nil end
		card:Destroy()
	end)
end

------------------------------------------------------------
-- Widgets (same API the feature code below uses)
------------------------------------------------------------
local function makeButton(parent, text, order, color)
	local b = new("TextButton", {
		LayoutOrder = order,
		Size = UDim2.new(1, -4, 0, 32),
		BackgroundColor3 = color,
		BackgroundTransparency = 0.12,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = C.text,
	}, parent)
	corner(b, 8)
	return b
end

local function makeToggle(parent, text, order, initial, callback)
	local btn = new("TextButton", {
		LayoutOrder = order,
		Size = UDim2.new(1, -4, 0, 32),
		BackgroundColor3 = C.row,
		BackgroundTransparency = 0.2,
		Text = "",
		AutoButtonColor = false,
	}, parent)
	corner(btn, 8)
	new("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -62, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextColor3 = C.text,
		Text = text,
	}, btn)
	local pill = new("Frame", {
		Size = UDim2.fromOffset(36, 18),
		Position = UDim2.new(1, -46, 0.5, -9),
		BorderSizePixel = 0,
	}, btn)
	corner(pill, 9)
	local knob = new("Frame", {
		Size = UDim2.fromOffset(14, 14),
		BackgroundColor3 = C.text,
		BorderSizePixel = 0,
	}, pill)
	corner(knob, 7)

	local state = initial and true or false
	local function paint(animate)
		local pc = state and C.ice or C.gray
		local kp = state and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 2)
		if animate then
			local ti = TweenInfo.new(0.12)
			TweenService:Create(pill, ti, { BackgroundColor3 = pc }):Play()
			TweenService:Create(knob, ti, { Position = kp }):Play()
		else
			pill.BackgroundColor3 = pc
			knob.Position = kp
		end
	end
	paint(false)

	btn.MouseButton1Click:Connect(function()
		state = not state
		paint(true)
		local ok, err = pcall(callback, state)
		if not ok then warn("[FrostUniversal] " .. text .. ": " .. tostring(err)) end
	end)

	return {
		set = function(on)
			on = on and true or false
			if on == state then return end
			state = on
			paint(true)
		end,
		destroy = function() btn:Destroy() end,
	}
end

local function makeBox(parent, order, placeholder, text, height, multi)
	local box = new("TextBox", {
		LayoutOrder = order,
		Size = UDim2.new(1, -4, 0, height or 30),
		BackgroundColor3 = C.dark,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = C.text,
		PlaceholderText = placeholder,
		PlaceholderColor3 = Color3.fromRGB(120, 145, 180),
		Text = text or "",
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = multi and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
		MultiLine = multi and true or false,
		TextWrapped = multi and true or false,
	}, parent)
	corner(box, 8)
	new("UIPadding", {
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
		PaddingTop = UDim.new(0, multi and 6 or 0),
	}, box)
	return box
end

------------------------------------------------------------
-- Dragging (mouse + touch), kept on screen
------------------------------------------------------------
local minimized = false
local draggables = {}

local function clampTo(d)
	local screen = gui.AbsoluteSize
	if screen.X < 50 or screen.Y < 50 then return end
	local p = d.target.Position
	local x = p.X.Scale * screen.X + p.X.Offset
	local y = p.Y.Scale * screen.Y + p.Y.Offset
	x = math.clamp(x, 0, math.max(screen.X - d.w, 0))
	y = math.clamp(y, 0, math.max(screen.Y - (d.keepH or d.h), 0))
	d.target.Position = UDim2.fromOffset(x, y)
end

local function reclampAll()
	for _, d in ipairs(draggables) do pcall(clampTo, d) end
end

-- drag `target` by grabbing `handle`. d.moved tells taps apart from drags.
local function makeDraggable(handle, target, w, h, keepH)
	local d = { target = target, w = w, h = h, keepH = keepH, moved = false }
	draggables[#draggables + 1] = d
	local active, startInput, dragStart, startPos = false, nil, nil, nil

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			active = true
			d.moved = false
			startInput = input
			dragStart = input.Position
			local screen = gui.AbsoluteSize
			local p = target.Position
			startPos = Vector2.new(p.X.Scale * screen.X + p.X.Offset, p.Y.Scale * screen.Y + p.Y.Offset)
		end
	end)
	track(UserInputService.InputChanged:Connect(function(input)
		if not active then return end
		if input == startInput or input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			if delta.Magnitude > 6 then d.moved = true end
			if d.moved then
				target.Position = UDim2.fromOffset(startPos.X + delta.X, startPos.Y + delta.Y)
				clampTo(d)
			end
		end
	end))
	track(UserInputService.InputEnded:Connect(function(input)
		if not active then return end
		if input == startInput or input.UserInputType == Enum.UserInputType.MouseButton1 then
			active = false
		end
	end))
	return d
end

local mainDrag = makeDraggable(header, main, W, H, HEADER_H)

-- screen rotated / resized: keep the hub usable and on screen
local function relayout()
	local s = gui.AbsoluteSize
	if s.X < 50 or s.Y < 50 then return end
	local newH = math.clamp(s.Y - 40, 230, 300)
	if newH ~= H then
		H = newH
		mainDrag.h = H
		if main.Visible and not minimized then main.Size = UDim2.fromOffset(W, H) end
	end
	reclampAll()
end
pcall(function()
	track(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(relayout))
end)

------------------------------------------------------------
-- Performance helpers: big jobs run a few milliseconds per frame
------------------------------------------------------------
local SLICE_BUDGET = tonumber(CONFIG.SliceBudget) or 0.0015

-- run fn(item) over `list` without ever hogging a frame; stops early if alive() turns false
local function sliceEach(list, fn, alive)
	local i, n = 1, #list
	while i <= n do
		if alive and not alive() then return false end
		local t0 = os.clock()
		repeat
			local stop = math.min(i + 11, n)
			for k = i, stop do pcall(fn, list[k]) end
			i = stop + 1
		until i > n or os.clock() - t0 > SLICE_BUDGET
		RunService.Heartbeat:Wait()
	end
	return true
end

-- only one heavy workspace scan (boost / dark textures) runs at a time, so
-- toggling several things at once can no longer stack up and cause a freeze
local heavyLock = { busy = false, queue = {} }
local function runHeavy(fn, onDone)
	if heavyLock.busy then
		table.insert(heavyLock.queue, { fn = fn, onDone = onDone })
		return
	end
	heavyLock.busy = true
	task.spawn(function()
		local ok, err = pcall(fn)
		if not ok then warn("[FrostBoost] " .. tostring(err)) end
		if onDone then pcall(onDone) end
		heavyLock.busy = false
		local nxt = table.remove(heavyLock.queue, 1)
		if nxt then runHeavy(nxt.fn, nxt.onDone) end
	end)
end

local function getProp(inst, prop) return inst[prop] end
local function setProp(inst, prop, value) inst[prop] = value end

-- records look like { instance, prop1, value1, prop2, value2, ... }
local function restoreRecords(records, onDone)
	runHeavy(function()
		sliceEach(records, function(rec)
			local inst = rec[1]
			for k = 2, #rec, 2 do pcall(setProp, inst, rec[k], rec[k + 1]) end
		end)
	end, onDone)
end


------------------------------------------------------------
-- Shadows
------------------------------------------------------------
local shadowsOn = Lighting.GlobalShadows
local shadowConn = nil   -- (unused now, kept so cleanup stays compatible)

-- GlobalShadows alone switches shadows off for the whole scene, so we no longer
-- touch CastShadow on every part (that full scan was a big source of lag).
local function setShadows(on)
	shadowsOn = on
	Lighting.GlobalShadows = on
end

------------------------------------------------------------
-- FPS boost
------------------------------------------------------------
local boost = {
	on = false, busy = false, saved = {}, conn = nil, gen = 0, prevShadows = true,
	seen = setmetatable({}, { __mode = "k" }),
}
local shadowToggle = nil

local FACE_CLASSES = { Decal = true, Texture = true }
local OFF_CLASSES = {
	ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true,
	BloomEffect = true, BlurEffect = true, ColorCorrectionEffect = true,
	DepthOfFieldEffect = true, SunRaysEffect = true,
}
local SMOOTH = Enum.Material.SmoothPlastic

-- one compact record per instance, written/saved only when something really changes
local function optimize(inst)
	local seen = boost.seen
	if seen[inst] then return end
	local cls = inst.ClassName
	if FACE_CLASSES[cls] then
		seen[inst] = true
		if inst.Transparency < 1 then
			local s = boost.saved
			s[#s + 1] = { inst, "Transparency", inst.Transparency }
			inst.Transparency = 1
		end
	elseif OFF_CLASSES[cls] then
		seen[inst] = true
		if inst.Enabled then
			local s = boost.saved
			s[#s + 1] = { inst, "Enabled", true }
			inst.Enabled = false
		end
	elseif cls ~= "Terrain" and inst:IsA("BasePart") then
		seen[inst] = true
		local mat, refl = inst.Material, inst.Reflectance
		if mat ~= SMOOTH or refl ~= 0 then
			local s = boost.saved
			s[#s + 1] = { inst, "Material", mat, "Reflectance", refl }
			inst.Material = SMOOTH
			inst.Reflectance = 0
		end
	end
end

local boostBtn = makeButton(pgBoost, "ENABLE BOOST", 1, C.green)

local function enableBoost()
	if boost.busy then
		setStatus("Still restoring the last boost, one moment...")
		return
	end
	boost.on = true
	boost.saved = {}
	boost.seen = setmetatable({}, { __mode = "k" })
	boost.gen += 1
	local gen = boost.gen

	boost.prevShadows = shadowsOn
	setShadows(false)
	if shadowToggle then shadowToggle.set(false) end

	local function keep(inst, prop)
		local ok, v = pcall(getProp, inst, prop)
		if ok then boost.saved[#boost.saved + 1] = { inst, prop, v } end
	end

	keep(Lighting, "FogEnd")
	pcall(setProp, Lighting, "FogEnd", 9e9)

	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if terrain then
		for _, p in ipairs({ "WaterWaveSize", "WaterWaveSpeed", "WaterReflectance", "WaterTransparency" }) do
			keep(terrain, p)
			pcall(setProp, terrain, p, 0)
		end
	end

	pcall(function()
		local r = settings().Rendering
		keep(r, "QualityLevel")
		r.QualityLevel = Enum.QualityLevel.Level01
	end)

	-- things created while boosting are queued and handled in small time slices
	local pending, pHead, pTail = {}, 1, 0
	local queued = setmetatable({}, { __mode = "k" })
	boost.conn = workspace.DescendantAdded:Connect(function(inst)
		if queued[inst] then return end
		queued[inst] = true
		pTail += 1
		pending[pTail] = inst
	end)

	local function alive() return boost.on and boost.gen == gen end

	for _, inst in ipairs(Lighting:GetChildren()) do pcall(optimize, inst) end
	runHeavy(function()
		sliceEach(workspace:GetDescendants(), optimize, alive)
	end, function()
		while alive() do
			if pHead <= pTail then
				local t0 = os.clock()
				while pHead <= pTail and os.clock() - t0 < SLICE_BUDGET do
					local item = pending[pHead]
					pending[pHead] = nil
					pHead += 1
					queued[item] = nil
					if item.Parent then pcall(optimize, item) end
				end
				if pHead > pTail then pending, pHead, pTail = {}, 1, 0 end
				RunService.Heartbeat:Wait()
			else
				task.wait(0.4)
			end
		end
	end)

	boostBtn.Text = "DISABLE BOOST"
	boostBtn.BackgroundColor3 = C.red
	setStatus("Boost ON: shadows, textures, particles, effects reduced.")
	showToast("Boost: ON")
end

local function disableBoost()
	boost.on = false
	boost.gen += 1
	if boost.conn then
		boost.conn:Disconnect()
		boost.conn = nil
	end
	local saved = boost.saved
	boost.saved = {}
	boost.seen = setmetatable({}, { __mode = "k" })
	boost.busy = true
	restoreRecords(saved, function() boost.busy = false end)

	setShadows(boost.prevShadows)
	if shadowToggle then shadowToggle.set(boost.prevShadows) end

	boostBtn.Text = "ENABLE BOOST"
	boostBtn.BackgroundColor3 = C.green
	setStatus("Boost OFF: restoring original settings.")
	showToast("Boost: OFF")
end

boostBtn.MouseButton1Click:Connect(function()
	if boost.on then disableBoost() else enableBoost() end
end)

------------------------------------------------------------
-- Stretch resolution (experimental camera effect)
------------------------------------------------------------
local stretchEnabled = false
local STRETCH_NAME = "FrostStretchRes"
local stretchScale = 0.65
local stretchCF = CFrame.new(0, 0, 0, 1, 0, 0, 0, stretchScale, 0, 0, 0, 1)   -- built once
local stretchLast = nil
local stretchBtn = makeButton(pgBoost, "STRETCH RESOLUTION: OFF", 10, C.blue)

local function stopStretch()
	if not stretchEnabled then return end
	stretchEnabled = false
	pcall(function() RunService:UnbindFromRenderStep(STRETCH_NAME) end)
	stretchLast = nil
	stretchBtn.Text = "STRETCH RESOLUTION: OFF"
	stretchBtn.BackgroundColor3 = C.blue
	setStatus("Stretch resolution OFF.")
end

local function startStretch()
	if stretchEnabled then return end
	stretchEnabled = true
	-- runs right AFTER the camera scripts, so it never fights them or compounds
	pcall(function()
		RunService:BindToRenderStep(STRETCH_NAME, Enum.RenderPriority.Camera.Value + 1, function()
			local cam = workspace.CurrentCamera
			if not cam then return end
			local cf = cam.CFrame
			if cf == stretchLast then return end   -- nobody rewrote it this frame: don't stack the effect
			stretchLast = cf * stretchCF
			cam.CFrame = stretchLast
		end)
	end)
	stretchBtn.Text = "STRETCH RESOLUTION: ON"
	stretchBtn.BackgroundColor3 = C.green
	setStatus("Stretch camera effect ON (experimental).")
end

stretchBtn.Activated:Connect(function()
	if stretchEnabled then stopStretch() else startStretch() end
end)

shadowToggle = makeToggle(pgBoost, "Shadows", 2, shadowsOn, function(on)
	setShadows(on)
	setStatus(on and "Shadows ON." or "Shadows OFF.")
end)

------------------------------------------------------------
-- Dark textures
------------------------------------------------------------
local DARK = Color3.fromRGB(38, 38, 44)
local DARK_TEX = Color3.fromRGB(45, 45, 50)
local DARK_AMBIENT = Color3.fromRGB(32, 32, 38)
local dark = { on = false, busy = false, saved = {}, conn = nil, gen = 0, seen = setmetatable({}, { __mode = "k" }) }

-- Is this Model a character? Cached, so big models aren't re-scanned for every part.
local charCache = setmetatable({}, { __mode = "k" })   -- model -> true | expiry time (not a character)
local function isCharModel(m)
	if Players:GetPlayerFromCharacter(m) then
		charCache[m] = true
		return true
	end
	local c = charCache[m]
	if c == true then return true end
	local now = os.clock()
	if c and now < c then return false end
	local isChar = m:FindFirstChildOfClass("Humanoid") ~= nil
	charCache[m] = isChar or (now + 5)
	return isChar
end

local function isCharPart(inst)
	local p, depth = inst.Parent, 0
	while p and p ~= workspace and depth < 8 do
		if p.ClassName == "Model" and isCharModel(p) then return true end
		p = p.Parent
		depth += 1
	end
	return false
end

local function darken(inst)
	local seen = dark.seen
	if seen[inst] then return end
	local cls = inst.ClassName
	if cls == "Decal" or cls == "Texture" then
		if isCharPart(inst) then return end
		seen[inst] = true
		local s = dark.saved
		s[#s + 1] = { inst, "Color3", inst.Color3 }
		inst.Color3 = DARK_TEX
	elseif cls == "SurfaceAppearance" then
		seen[inst] = true
		local s = dark.saved
		s[#s + 1] = { inst, "Color", inst.Color }
		inst.Color = DARK_TEX
	elseif cls ~= "Terrain" and inst:IsA("BasePart") then
		if isCharPart(inst) then return end
		seen[inst] = true
		local s = dark.saved
		s[#s + 1] = { inst, "Color", inst.Color }
		inst.Color = DARK
	end
end

local darkToggle = nil
local function setDark(on)
	dark.gen += 1
	local gen = dark.gen
	if on then
		if dark.busy then
			setStatus("Still restoring the last change, one moment...")
			task.defer(function() if darkToggle then darkToggle.set(false) end end)
			return
		end
		dark.on = true
		dark.saved = {}
		dark.seen = setmetatable({}, { __mode = "k" })
		dark.saved[1] = { Lighting, "Ambient", Lighting.Ambient, "OutdoorAmbient", Lighting.OutdoorAmbient }
		Lighting.Ambient = DARK_AMBIENT
		Lighting.OutdoorAmbient = DARK_AMBIENT
		dark.conn = workspace.DescendantAdded:Connect(function(inst)
			pcall(darken, inst)
		end)
		runHeavy(function()
			sliceEach(workspace:GetDescendants(), darken, function()
				return dark.on and dark.gen == gen
			end)
		end)
		setStatus("Dark textures ON.")
		showToast("Dark Textures: ON")
	else
		dark.on = false
		if dark.conn then
			dark.conn:Disconnect()
			dark.conn = nil
		end
		local saved = dark.saved
		dark.saved = {}
		dark.seen = setmetatable({}, { __mode = "k" })
		dark.busy = true
		restoreRecords(saved, function() dark.busy = false end)
		setStatus("Dark textures OFF.")
		showToast("Dark Textures: OFF")
	end
end
darkToggle = makeToggle(pgBoost, "Dark Textures", 3, false, setDark)

------------------------------------------------------------
-- FPS unlock / low detail / net + physics lite
------------------------------------------------------------
local unlockT = nil
unlockT = makeToggle(pgBoost, "FPS Unlock", 4, false, function(on)
	if setfpscap then
		pcall(setfpscap, on and 0 or 60)
		setStatus(on and "FPS cap removed." or "FPS cap back to 60.")
		showToast(on and "FPS Unlock: ON" or "FPS Unlock: OFF")
	else
		setStatus("FPS Unlock isn't supported by your executor.")
		task.defer(function() unlockT.set(false) end)
	end
end)

local lowSaved = {}
makeToggle(pgBoost, "Low-Detail Render", 5, false, function(on)
	if on then
		lowSaved = {}
		pcall(function()
			if gethiddenproperty and sethiddenproperty then
				lowSaved.tech = gethiddenproperty(Lighting, "Technology")
				sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
			end
		end)
		pcall(function()
			lowSaved.mesh = settings().Rendering.MeshPartDetailLevel
			settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
		end)
		pcall(function()
			local t = workspace:FindFirstChildOfClass("Terrain")
			lowSaved.deco = t.Decoration
			t.Decoration = false
		end)
		setStatus("Low-detail rendering ON.")
		showToast("Low-Detail Render: ON")
	else
		pcall(function()
			if lowSaved.tech ~= nil and sethiddenproperty then
				sethiddenproperty(Lighting, "Technology", lowSaved.tech)
			end
		end)
		pcall(function()
			if lowSaved.mesh ~= nil then settings().Rendering.MeshPartDetailLevel = lowSaved.mesh end
		end)
		pcall(function()
			local t = workspace:FindFirstChildOfClass("Terrain")
			if lowSaved.deco ~= nil then t.Decoration = lowSaved.deco end
		end)
		setStatus("Low-detail rendering OFF.")
	end
end)

------------------------------------------------------------
-- More tools (BOOST tab): Anti-AFK, mute, rejoin
------------------------------------------------------------
do
	local afkConn = nil
	makeToggle(pgBoost, "Anti-AFK", 7, false, function(on)
		if afkConn then
			afkConn:Disconnect()
			afkConn = nil
		end
		if on then
			afkConn = player.Idled:Connect(function()
				pcall(function()
					local vu = game:GetService("VirtualUser")
					vu:CaptureController()
					vu:ClickButton2(Vector2.new())
				end)
			end)
			setStatus("Anti-AFK ON: idling won't kick you.")
		else
			setStatus("Anti-AFK OFF.")
		end
	end)
	cleanups[#cleanups + 1] = function()
		if afkConn then
			afkConn:Disconnect()
			afkConn = nil
		end
	end

	local muteSaved = nil
	local function setMute(on)
		return (pcall(function()
			local gs = UserSettings():GetService("UserGameSettings")
			if on then
				muteSaved = gs.MasterVolume
				gs.MasterVolume = 0
			elseif muteSaved ~= nil then
				gs.MasterVolume = muteSaved
				muteSaved = nil
			end
		end))
	end
	local muteToggle = nil
	muteToggle = makeToggle(pgBoost, "Mute Game Audio", 8, false, function(on)
		if setMute(on) then
			setStatus(on and "Game audio muted." or "Game audio restored.")
		else
			setStatus("Muting isn't supported by your executor.")
			task.defer(function() muteToggle.set(false) end)
		end
	end)
	cleanups[#cleanups + 1] = function() setMute(false) end

	local rejoinBtn = makeButton(pgBoost, "REJOIN SERVER", 9, C.gray)
	rejoinBtn.MouseButton1Click:Connect(function()
		setStatus("Rejoining...")
		pcall(function()
			local TeleportService = game:GetService("TeleportService")
			if #Players:GetPlayers() <= 1 then
				TeleportService:Teleport(game.PlaceId, player)
			else
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
			end
		end)
	end)
end

------------------------------------------------------------
-- Players tab: hide everyone, or pick who disappears
------------------------------------------------------------
local hiddenState = {}   -- instance -> original value
local hideSet = {}       -- [Player] = true while hidden
local hideConns = {}     -- [Player] = { connections }
local rows = {}          -- [Player] = toggle row
local hideAllOn = false
local rowOrder = 100

local function hideInst(inst)
	if hiddenState[inst] ~= nil then return end
	if inst:IsA("BasePart") then
		hiddenState[inst] = inst.LocalTransparencyModifier
		inst.LocalTransparencyModifier = 1
	elseif inst:IsA("Decal") then
		hiddenState[inst] = inst.Transparency
		inst.Transparency = 1
	elseif inst:IsA("BillboardGui") then
		hiddenState[inst] = inst.Enabled
		inst.Enabled = false
	end
end

local function restoreInst(inst, orig)
	pcall(function()
		if inst:IsA("BasePart") then
			inst.LocalTransparencyModifier = orig
		elseif inst:IsA("Decal") then
			inst.Transparency = orig
		elseif inst:IsA("BillboardGui") then
			inst.Enabled = orig
		end
	end)
end

local function setPlayerHidden(p, on)
	if p == player then return end
	if on then
		if hideSet[p] then return end
		hideSet[p] = true
		local conns = {}
		local function hook(char)
			for _, d in ipairs(char:GetDescendants()) do pcall(hideInst, d) end
			conns[#conns + 1] = char.DescendantAdded:Connect(function(d)
				pcall(hideInst, d)
			end)
		end
		if p.Character then hook(p.Character) end
		conns[#conns + 1] = p.CharacterAdded:Connect(hook)
		hideConns[p] = conns
	else
		if not hideSet[p] then return end
		hideSet[p] = nil
		for _, c in ipairs(hideConns[p] or {}) do c:Disconnect() end
		hideConns[p] = nil
		local char = p.Character
		if char then
			for inst, orig in pairs(hiddenState) do
				if inst:IsDescendantOf(char) then
					restoreInst(inst, orig)
					hiddenState[inst] = nil
				end
			end
		end
	end
end

-- My nametag: change or hide the name above your head (only you see it)
do
	new("TextLabel", {
		LayoutOrder = 1,
		Size = UDim2.new(1, -4, 0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = C.ice,
		TextStrokeTransparency = 0.5,
		Text = "MY NAMETAG (only you see it)",
	}, pgPlayers)
	local nameBox = makeBox(pgPlayers, 2, "new name above your head", "", 30, false)
	local nameRow = new("Frame", {
		LayoutOrder = 3,
		Size = UDim2.new(1, -4, 0, 32),
		BackgroundTransparency = 1,
	}, pgPlayers)
	local applyBtn = new("TextButton", {
		Size = UDim2.new(0.5, -3, 1, 0),
		BackgroundColor3 = C.blue,
		BackgroundTransparency = 0.1,
		Text = "APPLY",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = C.text,
	}, nameRow)
	corner(applyBtn, 8)
	local resetBtn = new("TextButton", {
		Position = UDim2.new(0.5, 3, 0, 0),
		Size = UDim2.new(0.5, -3, 1, 0),
		BackgroundColor3 = C.gray,
		BackgroundTransparency = 0.1,
		Text = "RESET",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = C.text,
	}, nameRow)
	corner(resetBtn, 8)

	local st = { text = nil, orig = nil, hooked = {}, conns = {}, guard = false, olds = {} }

	local function esc(s) return (s:gsub("%p", "%%%0")) end
	local function repl(s) return (s:gsub("%%", "%%%%")) end

	local function swap(txt)
		if not st.text or txt:find(st.text, 1, true) then return txt end
		local out = txt
		for _, o in ipairs(st.olds) do
			if o ~= "" then out = out:gsub(esc(o), repl(st.text)) end
		end
		return out
	end

	local function isTagLabel(d)
		return (d:IsA("TextLabel") or d:IsA("TextButton"))
			and (d:FindFirstAncestorOfClass("BillboardGui") ~= nil
				or d:FindFirstAncestorOfClass("SurfaceGui") ~= nil)
	end

	local function hookLabel(lbl)
		if st.hooked[lbl] ~= nil then return end
		st.hooked[lbl] = lbl.Text
		local function fix()
			if st.guard or not st.text then return end
			local nt = swap(lbl.Text)
			if nt ~= lbl.Text then
				st.guard = true
				pcall(function() lbl.Text = nt end)
				st.guard = false
			end
		end
		st.conns[#st.conns + 1] = lbl:GetPropertyChangedSignal("Text"):Connect(fix)
		fix()
	end

	local function applyToCharacter(char)
		local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
		if hum then
			if st.orig == nil then st.orig = hum.DisplayName end
			pcall(function() hum.DisplayName = st.text end)
		end
		st.olds = { player.Name, player.DisplayName, st.orig or "" }
		for _, d in ipairs(char:GetDescendants()) do
			if isTagLabel(d) then pcall(hookLabel, d) end
		end
		st.conns[#st.conns + 1] = char.DescendantAdded:Connect(function(d)
			task.defer(function()
				if st.text and d.Parent and isTagLabel(d) then pcall(hookLabel, d) end
			end)
		end)
	end

	local function resetName()
		for _, c in ipairs(st.conns) do pcall(function() c:Disconnect() end) end
		st.conns = {}
		st.text = nil
		for lbl, orig in pairs(st.hooked) do
			pcall(function()
				if lbl.Parent then lbl.Text = orig end
			end)
		end
		st.hooked = {}
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum and st.orig ~= nil then
			pcall(function() hum.DisplayName = st.orig end)
		end
		st.orig = nil
	end

	applyBtn.MouseButton1Click:Connect(function()
		local n = nameBox.Text:match("^%s*(.-)%s*$")
		if n == "" then
			setStatus("Type a name first.")
			return
		end
		if #n > 40 then n = n:sub(1, 40) end
		resetName()
		st.text = n
		if player.Character then task.spawn(applyToCharacter, player.Character) end
		setStatus("Nametag set to: " .. n .. " (only you see it)")
	end)
	resetBtn.MouseButton1Click:Connect(function()
		resetName()
		setStatus("Nametag reset.")
	end)
	track(player.CharacterAdded:Connect(function(char)
		if st.text then task.spawn(applyToCharacter, char) end
	end))
	cleanups[#cleanups + 1] = resetName

	local tagSaved = nil
	makeToggle(pgPlayers, "Hide My Nametag", 4, false, function(on)
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not hum then
			setStatus("Character isn't loaded yet.")
			return
		end
		if on then
			tagSaved = hum.DisplayDistanceType
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		elseif tagSaved ~= nil then
			hum.DisplayDistanceType = tagSaved
			tagSaved = nil
		end
	end)
end

makeToggle(pgPlayers, "Hide All Players", 10, false, function(on)
	hideAllOn = on
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			setPlayerHidden(p, on)
			if rows[p] then rows[p].set(on) end
		end
	end
	setStatus(on and "All other players hidden." or "Other players visible again.")
	showToast(on and "Hide All Players: ON" or "Hide All Players: OFF")
end)

new("TextLabel", {
	LayoutOrder = 11,
	Size = UDim2.new(1, -4, 0, 20),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.ice,
	TextStrokeTransparency = 0.5,
	Text = "PICK WHO DISAPPEARS",
}, pgPlayers)

local function addRow(p)
	if p == player or rows[p] then return end
	rowOrder += 1
	rows[p] = makeToggle(pgPlayers, "• " .. p.DisplayName, rowOrder, hideSet[p] == true, function(on)
		setPlayerHidden(p, on)
		setStatus((on and "Hidden: " or "Visible: ") .. p.DisplayName)
	end)
end

local function removeRow(p)
	setPlayerHidden(p, false)
	if rows[p] then
		rows[p].destroy()
		rows[p] = nil
	end
end

for _, p in ipairs(Players:GetPlayers()) do addRow(p) end
track(Players.PlayerAdded:Connect(function(p)
	addRow(p)
	if hideAllOn then
		setPlayerHidden(p, true)
		if rows[p] then rows[p].set(true) end
	end
end))
track(Players.PlayerRemoving:Connect(removeRow))

------------------------------------------------------------
-- POTATO MODE (boost + extreme extras), HIDE MESHES, 3D OFF
------------------------------------------------------------
local potato = {
	on = false, busy = false, saved = {}, conn = nil, gen = 0, boostByMe = false, tech = nil,
	seen = setmetatable({}, { __mode = "k" }),
}
local POTATO_OFF = { PointLight = true, SpotLight = true, SurfaceLight = true, Highlight = true }
local PERF = Enum.RenderFidelity.Performance
local potatoToggle = nil

-- per item: lights/highlights off, meshes flat + untextured. Only records what it really changes.
local function potatoItem(inst)
	local seen = potato.seen
	if seen[inst] then return end
	local cls = inst.ClassName
	if POTATO_OFF[cls] then
		seen[inst] = true
		if inst.Enabled then
			local s = potato.saved
			s[#s + 1] = { inst, "Enabled", true }
			inst.Enabled = false
		end
	elseif cls == "MeshPart" then
		if isCharPart(inst) then return end
		seen[inst] = true
		local rf, tex = inst.RenderFidelity, inst.TextureID
		if rf ~= PERF or tex ~= "" then
			local s = potato.saved
			s[#s + 1] = { inst, "RenderFidelity", rf, "TextureID", tex }
			inst.RenderFidelity = PERF
			inst.TextureID = ""
		end
	elseif cls == "UnionOperation" then
		seen[inst] = true
		local rf = inst.RenderFidelity
		if rf ~= PERF then
			local s = potato.saved
			s[#s + 1] = { inst, "RenderFidelity", rf }
			inst.RenderFidelity = PERF
		end
	end
end

-- one-time global extras (lighting, haze, terrain grass, mesh detail, lighting tech)
local function potatoExtras()
	local s = potato.saved
	local function add(inst, rec, prop, target)
		local ok, cur = pcall(getProp, inst, prop)
		if ok and cur ~= target then
			rec[#rec + 1] = prop
			rec[#rec + 1] = cur
			pcall(setProp, inst, prop, target)
		end
	end
	local lrec = { Lighting }
	add(Lighting, lrec, "EnvironmentDiffuseScale", 0)
	add(Lighting, lrec, "EnvironmentSpecularScale", 0)
	add(Lighting, lrec, "ShadowSoftness", 0)
	if #lrec > 1 then s[#s + 1] = lrec end
	for _, child in ipairs(Lighting:GetChildren()) do
		if child.ClassName == "Atmosphere" then
			local arec = { child }
			add(child, arec, "Density", 0)
			add(child, arec, "Haze", 0)
			add(child, arec, "Glare", 0)
			if #arec > 1 then s[#s + 1] = arec end
		end
	end
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if terrain then
		local trec = { terrain }
		add(terrain, trec, "Decoration", false)
		if #trec > 1 then s[#s + 1] = trec end
	end
	pcall(function()
		local r = settings().Rendering
		local rrec = { r }
		add(r, rrec, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level04)
		if #rrec > 1 then s[#s + 1] = rrec end
	end)
	pcall(function()
		if gethiddenproperty and sethiddenproperty then
			local cur = gethiddenproperty(Lighting, "Technology")
			if cur ~= Enum.Technology.Compatibility then
				potato.tech = cur
				sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
			end
		end
	end)
end

local function setPotato(on)
	potato.gen += 1
	local gen = potato.gen
	if on then
		if potato.busy then
			setStatus("Still restoring the last change, one moment...")
			task.defer(function() if potatoToggle then potatoToggle.set(false) end end)
			return
		end
		potato.on = true
		potato.saved = {}
		potato.seen = setmetatable({}, { __mode = "k" })
		potato.tech = nil
		potato.boostByMe = not boost.on
		if potato.boostByMe then enableBoost() end   -- the boost does materials/textures/particles/effects/shadows
		potatoExtras()
		potato.conn = workspace.DescendantAdded:Connect(function(inst)
			pcall(potatoItem, inst)
		end)
		runHeavy(function()
			sliceEach(workspace:GetDescendants(), potatoItem, function()
				return potato.on and potato.gen == gen
			end)
		end)
		setStatus("Potato Mode ON: boost + lights off, flat meshes, no haze.")
		showToast("Potato Mode: ON")
	else
		potato.on = false
		if potato.conn then
			potato.conn:Disconnect()
			potato.conn = nil
		end
		local saved = potato.saved
		potato.saved = {}
		potato.seen = setmetatable({}, { __mode = "k" })
		potato.busy = true
		restoreRecords(saved, function() potato.busy = false end)
		pcall(function()
			if potato.tech ~= nil and sethiddenproperty then
				sethiddenproperty(Lighting, "Technology", potato.tech)
			end
		end)
		potato.tech = nil
		if potato.boostByMe and boost.on then disableBoost() end
		potato.boostByMe = false
		setStatus("Potato Mode OFF.")
		showToast("Potato Mode: OFF")
	end
end
potatoToggle = makeToggle(pgBoost, "POTATO MODE (extreme)", 0, false, setPotato)

-- hide map meshes (characters are never touched; client-side only)
local meshHide = { on = false, busy = false, saved = {}, conn = nil, gen = 0, seen = setmetatable({}, { __mode = "k" }) }
local meshToggle = nil

local function meshItem(inst)
	local seen = meshHide.seen
	if seen[inst] then return end
	local cls = inst.ClassName
	local target = nil
	if cls == "MeshPart" then
		target = inst
	elseif cls == "SpecialMesh" then
		target = inst.Parent
	end
	if target and not seen[target] and target:IsA("BasePart") then
		if isCharPart(target) then return end
		seen[inst] = true
		seen[target] = true
		local s = meshHide.saved
		s[#s + 1] = { target, "LocalTransparencyModifier", target.LocalTransparencyModifier }
		target.LocalTransparencyModifier = 1
	end
end

local function setMeshHide(on)
	meshHide.gen += 1
	local gen = meshHide.gen
	if on then
		if meshHide.busy then
			setStatus("Still restoring the last change, one moment...")
			task.defer(function() if meshToggle then meshToggle.set(false) end end)
			return
		end
		meshHide.on = true
		meshHide.saved = {}
		meshHide.seen = setmetatable({}, { __mode = "k" })
		meshHide.conn = workspace.DescendantAdded:Connect(function(inst)
			pcall(meshItem, inst)
		end)
		runHeavy(function()
			sliceEach(workspace:GetDescendants(), meshItem, function()
				return meshHide.on and meshHide.gen == gen
			end)
		end)
		setStatus("Meshes hidden (map only, characters stay visible).")
		showToast("Hide Meshes: ON")
	else
		meshHide.on = false
		if meshHide.conn then
			meshHide.conn:Disconnect()
			meshHide.conn = nil
		end
		local saved = meshHide.saved
		meshHide.saved = {}
		meshHide.seen = setmetatable({}, { __mode = "k" })
		meshHide.busy = true
		restoreRecords(saved, function() meshHide.busy = false end)
		setStatus("Meshes visible again.")
		showToast("Hide Meshes: OFF")
	end
end
meshToggle = makeToggle(pgBoost, "Hide Meshes (map)", 11, false, setMeshHide)

-- 3D rendering off: black screen, near-zero GPU use (great for AFK)
local function set3d(off)
	pcall(function() RunService:Set3dRenderingEnabled(not off) end)
end
makeToggle(pgBoost, "3D OFF (AFK black screen)", 12, false, function(on)
	set3d(on)
	setStatus(on and "3D rendering off. Toggle again to see the game." or "3D rendering back on.")
	showToast(on and "3D Rendering: OFF" or "3D Rendering: ON")
end)

------------------------------------------------------------
-- ULTRA FPS BOOST: potato + PBR textures off + other players' animations frozen
------------------------------------------------------------
local animF = { on = false, conns = {} }
local freezeToggle = nil

local function freezeChar(char)
	local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
	if not hum or not animF.on then return end
	local animator = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
	if not animator or not animF.on then return end
	for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
		pcall(function() tr:Stop(0) end)
	end
	animF.conns[#animF.conns + 1] = animator.AnimationPlayed:Connect(function(tr)
		pcall(function() tr:Stop(0) end)
	end)
end

local function freezePlayer(p)
	if p == player then return end
	if p.Character then task.spawn(freezeChar, p.Character) end
	animF.conns[#animF.conns + 1] = p.CharacterAdded:Connect(function(c)
		task.spawn(freezeChar, c)
	end)
end

local function setFreezeAnims(on)
	for _, c in ipairs(animF.conns) do pcall(function() c:Disconnect() end) end
	animF.conns = {}
	animF.on = on
	if on then
		for _, p in ipairs(Players:GetPlayers()) do freezePlayer(p) end
		animF.conns[#animF.conns + 1] = Players.PlayerAdded:Connect(freezePlayer)
	end
end
freezeToggle = makeToggle(pgBoost, "Freeze other players' animations", 13, false, function(on)
	setFreezeAnims(on)
	setStatus(on and "Other players' animations frozen (big win in crowded servers)." or "Animations back to normal.")
	showToast(on and "Freeze Animations: ON" or "Freeze Animations: OFF")
end)

local ultra = {
	on = false, busy = false, saved = {}, conn = nil, gen = 0,
	potatoByMe = false, freezeByMe = false,
	seen = setmetatable({}, { __mode = "k" }),
}
local ultraToggle = nil

-- PBR textures (SurfaceAppearance) are very heavy: take them off (put back on restore)
local function ultraItem(inst)
	if ultra.seen[inst] then return end
	if inst.ClassName == "SurfaceAppearance" then
		ultra.seen[inst] = true
		local parent = inst.Parent
		if parent then
			local s = ultra.saved
			s[#s + 1] = { inst, "Parent", parent }
			inst.Parent = nil
		end
	end
end

local function setUltra(on)
	ultra.gen += 1
	local gen = ultra.gen
	if on then
		if ultra.busy then
			setStatus("Still restoring the last change, one moment...")
			task.defer(function() if ultraToggle then ultraToggle.set(false) end end)
			return
		end
		ultra.on = true
		ultra.saved = {}
		ultra.seen = setmetatable({}, { __mode = "k" })
		ultra.potatoByMe = not potato.on
		if ultra.potatoByMe then
			setPotato(true)
			if potatoToggle then potatoToggle.set(true) end
		end
		ultra.freezeByMe = not animF.on
		if ultra.freezeByMe then
			setFreezeAnims(true)
			if freezeToggle then freezeToggle.set(true) end
		end
		ultra.conn = workspace.DescendantAdded:Connect(function(inst)
			pcall(ultraItem, inst)
		end)
		runHeavy(function()
			sliceEach(workspace:GetDescendants(), ultraItem, function()
				return ultra.on and ultra.gen == gen
			end)
		end)
		setStatus("ULTRA BOOST ON: potato + no PBR textures + frozen animations. Also try FPS Unlock.")
		showToast("Ultra Boost: ON")
	else
		ultra.on = false
		if ultra.conn then
			ultra.conn:Disconnect()
			ultra.conn = nil
		end
		local saved = ultra.saved
		ultra.saved = {}
		ultra.seen = setmetatable({}, { __mode = "k" })
		ultra.busy = true
		restoreRecords(saved, function() ultra.busy = false end)
		if ultra.potatoByMe and potato.on then
			setPotato(false)
			if potatoToggle then potatoToggle.set(false) end
		end
		if ultra.freezeByMe and animF.on then
			setFreezeAnims(false)
			if freezeToggle then freezeToggle.set(false) end
		end
		ultra.potatoByMe, ultra.freezeByMe = false, false
		setStatus("Ultra Boost OFF.")
		showToast("Ultra Boost: OFF")
	end
end
ultraToggle = makeToggle(pgBoost, "ULTRA FPS BOOST (max)", -1, false, setUltra)

------------------------------------------------------------
-- Settings page
------------------------------------------------------------
local function executorName()
	local ok, n = pcall(function() return identifyexecutor and identifyexecutor() end)
	if ok and n then return tostring(n) end
	ok, n = pcall(function() return getexecutorname and getexecutorname() end)
	if ok and n then return tostring(n) end
	return "unknown executor"
end

do
	local presets = { { "SMOOTH", 0.001 }, { "BALANCED", 0.0015 }, { "FAST", 0.004 } }
	local idx = 2
	local sBtn = makeButton(pgSettings, "SMOOTHNESS: BALANCED", 1, C.blue)
	sBtn.MouseButton1Click:Connect(function()
		idx = idx % #presets + 1
		SLICE_BUDGET = presets[idx][2]
		sBtn.Text = "SMOOTHNESS: " .. presets[idx][1]
		setStatus("Heavy jobs now use " .. presets[idx][1] .. " pacing.")
		showToast("Smoothness: " .. presets[idx][1])
	end)
	new("TextLabel", {
		LayoutOrder = 2, Size = UDim2.new(1, -4, 0, 44),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham,
		TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = C.dim,
		Text = "SMOOTH is easiest on a weak phone (big jobs finish slower). FAST finishes sooner but can hitch.",
	}, pgSettings)
	makeToggle(pgSettings, "Show FPS / PING chips", 3, true, function(on)
		fpsLabel.Visible = on
		pingLabel.Visible = on
	end)
	new("TextLabel", {
		LayoutOrder = 4, Size = UDim2.new(1, -4, 0, 30),
		BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
		TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = C.ice,
		Text = "Frost UNIVERSAL  |  running on " .. executorName(),
	}, pgSettings)

	-- credits
	local credits = new("Frame", {
		LayoutOrder = 5, Size = UDim2.new(1, -4, 0, 78),
		BackgroundColor3 = C.row, BackgroundTransparency = 0.2, BorderSizePixel = 0,
	}, pgSettings)
	corner(credits, 10)
	new("UIStroke", { Thickness = 1, Color = C.ice, Transparency = 0.6 }, credits)
	local cLogo = makeLogo(credits, 40)
	cLogo.Position = UDim2.fromOffset(10, 19)
	new("TextLabel", {
		Position = UDim2.fromOffset(60, 9), Size = UDim2.new(1, -68, 0, 14),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = C.ice, Text = "CREDITS",
	}, credits)
	local made = new("TextLabel", {
		Position = UDim2.fromOffset(60, 25), Size = UDim2.new(1, -68, 0, 22),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 14, TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = C.text,
		Text = "Made By Claude Ai And Frost",
	}, credits)
	new("UITextSizeConstraint", { MaxTextSize = 14, MinTextSize = 8 }, made)
	new("TextLabel", {
		Position = UDim2.fromOffset(60, 50), Size = UDim2.new(1, -68, 0, 18),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = C.dim,
		Text = "Frost UNIVERSAL - thanks for using it!",
	}, credits)
end

------------------------------------------------------------
-- STYLE page: accent colors, size, opacity, snow, mini HUD, replay intro
------------------------------------------------------------
local playIntro   -- (defined near the bottom)
local hudOn, hudLbl, hudBox = false, nil, nil

do
	local skipRecolor = {}
	local ACCENTS = {
		{ "ICE", Color3.fromRGB(140, 220, 255) },
		{ "PINK", Color3.fromRGB(255, 120, 200) },
		{ "MINT", Color3.fromRGB(110, 255, 190) },
		{ "GOLD", Color3.fromRGB(255, 205, 90) },
		{ "VIOLET", Color3.fromRGB(175, 135, 255) },
		{ "EMBER", Color3.fromRGB(255, 140, 80) },
	}

	-- recolor everything that currently uses the accent, in one pass
	local function applyAccent(new)
		local old = C.ice
		if new == old then return end
		C.ice = new
		for _, d in ipairs(gui:GetDescendants()) do
			if not skipRecolor[d] then
				local cls = d.ClassName
				if cls == "TextLabel" or cls == "TextButton" or cls == "TextBox" then
					if d.TextColor3 == old then d.TextColor3 = new end
					if d.BackgroundColor3 == old then d.BackgroundColor3 = new end
				elseif cls == "Frame" or cls == "ImageLabel" then
					if d.BackgroundColor3 == old then d.BackgroundColor3 = new end
				elseif cls == "UIStroke" then
					if d.Color == old then d.Color = new end
				elseif cls == "ScrollingFrame" then
					if d.ScrollBarImageColor3 == old then d.ScrollBarImageColor3 = new end
				end
			end
		end
		strokeGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, new),
			ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, C.blue),
		})
		titleGrad.Color = ColorSequence.new(Color3.new(1, 1, 1), new)
	end

	new("TextLabel", {
		LayoutOrder = 1, Size = UDim2.new(1, -4, 0, 18),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
		TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = C.dim, Text = "ACCENT COLOR",
	}, pgStyle)
	local swatchRow = new("Frame", {
		LayoutOrder = 2, Size = UDim2.new(1, -4, 0, 30), BackgroundTransparency = 1,
	}, pgStyle)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, swatchRow)
	for i, a in ipairs(ACCENTS) do
		local b = new("TextButton", {
			LayoutOrder = i, Size = UDim2.new(1 / #ACCENTS, -5, 1, 0),
			BackgroundColor3 = a[2], BorderSizePixel = 0,
			Text = a[1], Font = Enum.Font.GothamBold, TextSize = 8,
			TextColor3 = Color3.fromRGB(10, 18, 34),
		}, swatchRow)
		corner(b, 8)
		skipRecolor[b] = true
		b.MouseButton1Click:Connect(function()
			applyAccent(a[2])
			setStatus("Accent color: " .. a[1])
			showToast("Accent: " .. a[1])
		end)
	end

	-- UI size
	local uiScale = new("UIScale", { Scale = 1 }, main)
	local SIZES = { 0.8, 0.9, 1, 1.1 }
	local sizeIdx = 3
	local sizeBtn = makeButton(pgStyle, "UI SIZE: 100%", 3, C.blue)
	sizeBtn.MouseButton1Click:Connect(function()
		sizeIdx = sizeIdx % #SIZES + 1
		local sc = SIZES[sizeIdx]
		uiScale.Scale = sc
		mainDrag.w = W * sc
		mainDrag.h = H * sc
		mainDrag.keepH = HEADER_H * sc
		sizeBtn.Text = ("UI SIZE: %d%%"):format(sc * 100 + 0.5)
		reclampAll()
		setStatus("Hub size " .. sizeBtn.Text:sub(10))
	end)

	-- panel opacity
	local OPAC = { { "SOLID", 0.05 }, { "GLASS", 0.3 }, { "GHOST", 0.55 } }
	local opIdx = 1
	local opBtn = makeButton(pgStyle, "PANEL: SOLID", 4, C.blue)
	opBtn.MouseButton1Click:Connect(function()
		opIdx = opIdx % #OPAC + 1
		TweenService:Create(main, TweenInfo.new(0.2), { BackgroundTransparency = OPAC[opIdx][2] }):Play()
		opBtn.Text = "PANEL: " .. OPAC[opIdx][1]
		setStatus("Panel look: " .. OPAC[opIdx][1])
	end)

	-- floating FPS / PING chip that stays on screen even when the hub is closed
	makeToggle(pgStyle, "Floating FPS/PING chip", 6, false, function(on)
		hudOn = on
		if on and not hudBox then
			hudBox = new("Frame", {
				Size = UDim2.fromOffset(150, 24), Position = UDim2.new(1, -160, 0, 70),
				BackgroundColor3 = C.dark, BackgroundTransparency = 0.25,
				BorderSizePixel = 0, ZIndex = 50, Visible = false,
			}, gui)
			corner(hudBox, 12)
			new("UIStroke", { Thickness = 1, Color = C.ice, Transparency = 0.5 }, hudBox)
			hudLbl = new("TextLabel", {
				Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = C.text,
				Text = "FPS --  |  -- ms", ZIndex = 51,
			}, hudBox)
			makeDraggable(hudBox, hudBox, 150, 24, nil)
		end
		if hudBox then hudBox.Visible = on end
		showToast(on and "Floating Chip: ON" or "Floating Chip: OFF")
	end)

	local replay = makeButton(pgStyle, "REPLAY INTRO", 7, C.gray)
	replay.MouseButton1Click:Connect(function()
		playIntro(function() end)
	end)
end

------------------------------------------------------------
-- FONT EDITOR (game fonts) + GREY SKY
------------------------------------------------------------
local resetFonts, setGreySky = nil, nil
local greySkyOn = function() return false end

do
	local weak = function() return setmetatable({}, { __mode = "k" }) end
	local playerGui = player:WaitForChild("PlayerGui")
	local fs = {
		on = false, family = nil, saved = {}, seen = weak(), busy = false, gen = 0,
		includeHub = false, includeWorld = false,
		pgConn = nil, worldConn = nil, hubConn = nil,
	}

	local function isTextObj(inst)
		local c = inst.ClassName
		return c == "TextLabel" or c == "TextButton" or c == "TextBox"
	end

	local function allowed(inst)
		if not fs.includeHub and inst:IsDescendantOf(gui) then return false end
		if not fs.includeWorld and inst:IsDescendantOf(workspace) then return false end
		return true
	end

	-- keeps each label's own bold/italic, only swaps the family
	local function apply(inst)
		if fs.seen[inst] or not fs.family then return end
		if not isTextObj(inst) or not allowed(inst) then return end
		fs.seen[inst] = true
		local orig = inst.FontFace
		local s = fs.saved
		s[#s + 1] = { inst, "FontFace", orig }
		inst.FontFace = Font.new(fs.family, orig.Weight, orig.Style)
	end

	local function alive(gen)
		return function() return fs.on and fs.gen == gen end
	end

	local function scan(gen)
		runHeavy(function()
			sliceEach(playerGui:GetDescendants(), apply, alive(gen))
			if fs.includeHub and not gui:IsDescendantOf(playerGui) then
				sliceEach(gui:GetDescendants(), apply, alive(gen))
			end
			if fs.includeWorld then
				sliceEach(workspace:GetDescendants(), apply, alive(gen))
			end
		end)
	end

	local function onAdd(inst)
		if isTextObj(inst) then pcall(apply, inst) end
	end

	local function watch()
		if not fs.pgConn then
			fs.pgConn = playerGui.DescendantAdded:Connect(onAdd)
		end
		if fs.includeWorld and not fs.worldConn then
			fs.worldConn = workspace.DescendantAdded:Connect(onAdd)
		elseif not fs.includeWorld and fs.worldConn then
			fs.worldConn:Disconnect()
			fs.worldConn = nil
		end
		if fs.includeHub and not fs.hubConn then
			fs.hubConn = gui.DescendantAdded:Connect(onAdd)
		elseif not fs.includeHub and fs.hubConn then
			fs.hubConn:Disconnect()
			fs.hubConn = nil
		end
	end

	local function useFont(family, label)
		if fs.busy then
			setStatus("Still restoring fonts, one moment...")
			return
		end
		fs.family = family
		if not fs.on then
			fs.on = true
			fs.saved = {}
			fs.seen = weak()
			fs.gen += 1
			watch()
			scan(fs.gen)
		else
			-- a font is already active: swap the family on everything already touched
			local gen = fs.gen
			runHeavy(function()
				sliceEach(fs.saved, function(rec)
					rec[1].FontFace = Font.new(fs.family, rec[3].Weight, rec[3].Style)
				end, alive(gen))
			end)
		end
		setStatus("Font: " .. label)
		showToast("Font: " .. label)
	end

	function resetFonts()
		if not fs.on then
			setStatus("Fonts are already original.")
			return
		end
		fs.on = false
		fs.gen += 1
		for _, k in ipairs({ "pgConn", "worldConn", "hubConn" }) do
			if fs[k] then
				pcall(function() fs[k]:Disconnect() end)
				fs[k] = nil
			end
		end
		local saved = fs.saved
		fs.saved = {}
		fs.seen = weak()
		fs.family = nil
		fs.busy = true
		restoreRecords(saved, function() fs.busy = false end)
		setStatus("Fonts restored.")
		showToast("Fonts: reset")
	end

	-- scope switches (hub / world text) while a font is active
	local function syncScope()
		if not fs.on then return end
		for i = #fs.saved, 1, -1 do
			local rec = fs.saved[i]
			if not allowed(rec[1]) then
				pcall(setProp, rec[1], "FontFace", rec[3])
				fs.seen[rec[1]] = nil
				table.remove(fs.saved, i)
			end
		end
		watch()
		scan(fs.gen)
	end

	-- built-in fonts (anything that doesn't exist in this Roblox version is skipped)
	local builtin = {}
	for _, n in ipairs({
		"Arcade", "Fantasy", "Cartoon", "Bangers", "Creepster", "Fondamento", "FredokaOne",
		"IndieFlower", "Jura", "Kalam", "LuckiestGuy", "Nunito", "PatrickHand", "PermanentMarker",
		"SpecialElite", "Oswald", "Ubuntu", "RobotoMono", "Michroma", "SciFi", "Antique",
		"Highway", "Code", "Bodoni", "Garamond",
	}) do
		local ok, e = pcall(function() return Enum.Font[n] end)
		if ok and e then
			local ok2, f = pcall(Font.fromEnum, e)
			if ok2 and f then builtin[#builtin + 1] = { n, f.Family } end
		end
	end

	new("TextLabel", {
		LayoutOrder = 1, Size = UDim2.new(1, -4, 0, 44),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham,
		TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = C.dim,
		Text = "Changes the font of the game's text on your screen only. Pick a built-in font, or load your own .ttf / .otf file.",
	}, pgFonts)

	local idx = 0
	local nextBtn = makeButton(pgFonts, "NEXT BUILT-IN FONT", 2, C.blue)
	nextBtn.MouseButton1Click:Connect(function()
		if #builtin == 0 then
			setStatus("No built-in fonts available here.")
			return
		end
		idx = idx % #builtin + 1
		nextBtn.Text = "FONT: " .. builtin[idx][1] .. "  (tap = next)"
		useFont(builtin[idx][2], builtin[idx][1])
	end)

	local fileBox = makeBox(pgFonts, 3, "your font file name, e.g. myfont.ttf", "", 30, false)
	local loadBtn = makeButton(pgFonts, "LOAD FONT FILE", 4, C.green)
	loadBtn.MouseButton1Click:Connect(function()
		local fileName = fileBox.Text:match("^%s*(.-)%s*$")
		if not (writefile and isfile and getcustomasset) then
			setStatus("Font files need an executor with writefile, isfile and getcustomasset.")
			return
		end
		if fileName == "" then
			setStatus("Type your font file name first.")
			return
		end
		if not isfile(fileName) then
			setStatus("File not found. Put it in your executor's workspace folder.")
			showToast("Font file not found")
			return
		end
		local ok, family = pcall(function()
			local jsonName = "frosthubz_font_" .. (fileName:gsub("[^%w_]", "_")) .. ".json"
			local json = game:GetService("HttpService"):JSONEncode({
				name = "FrostHubzFont",
				faces = { { name = "Regular", weight = 400, style = "normal", assetId = getcustomasset(fileName) } },
			})
			writefile(jsonName, json)
			return getcustomasset(jsonName)
		end)
		if not ok or not family then
			setStatus("Couldn't load that font file (try a plain .ttf).")
			showToast("Font load failed")
			return
		end
		useFont(family, fileName)
	end)

	makeToggle(pgFonts, "Also change this hub's font", 5, false, function(on)
		fs.includeHub = on
		syncScope()
	end)
	makeToggle(pgFonts, "Include world text (signs/nametags)", 6, false, function(on)
		fs.includeWorld = on
		syncScope()
	end)
	local resetBtn = makeButton(pgFonts, "RESET FONTS", 7, C.red)
	resetBtn.MouseButton1Click:Connect(resetFonts)

	-- grey sky: hides the skybox sun/moon/stars + paints the sky a flat overcast grey
	local sky = { on = false, saved = {}, made = nil, busy = false }
	local SKY_FACES = { "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp" }
	local GREY = Color3.fromRGB(190, 190, 196)
	local GREY_DECAY = Color3.fromRGB(120, 120, 126)
	local skyToggle = nil

	local function add(inst, rec, prop, target)
		local ok, cur = pcall(getProp, inst, prop)
		if ok and cur ~= target then
			rec[#rec + 1] = prop
			rec[#rec + 1] = cur
			pcall(setProp, inst, prop, target)
		end
	end
	local function atmo(inst, rec)
		add(inst, rec, "Density", 0.6)
		add(inst, rec, "Offset", 1)
		add(inst, rec, "Color", GREY)
		add(inst, rec, "Decay", GREY_DECAY)
		add(inst, rec, "Glare", 0)
		add(inst, rec, "Haze", 4)
	end

	greySkyOn = function() return sky.on end
	function setGreySky(on)
		if on then
			if sky.busy then
				setStatus("Still restoring the sky, one moment...")
				task.defer(function() if skyToggle then skyToggle.set(false) end end)
				return
			end
			sky.on = true
			sky.saved = {}
			local s = sky.saved
			local haveAtmo = false
			for _, child in ipairs(Lighting:GetChildren()) do
				if child:IsA("Sky") then
					local rec = { child }
					add(child, rec, "CelestialBodiesShown", false)
					add(child, rec, "StarCount", 0)
					for _, face in ipairs(SKY_FACES) do add(child, rec, face, "") end
					if #rec > 1 then s[#s + 1] = rec end
				elseif child:IsA("Atmosphere") then
					haveAtmo = true
					local rec = { child }
					atmo(child, rec)
					if #rec > 1 then s[#s + 1] = rec end
				end
			end
			if not haveAtmo then
				local a = Instance.new("Atmosphere")
				a.Name = "FrostGreySky"
				local dummy = { a }
				atmo(a, dummy)
				a.Parent = Lighting
				sky.made = a
			end
			setStatus("Grey sky ON (works best with normal lighting, not Potato/Low-Detail).")
			showToast("Grey Sky: ON")
		else
			sky.on = false
			local saved = sky.saved
			sky.saved = {}
			if sky.made then
				pcall(function() sky.made:Destroy() end)
				sky.made = nil
			end
			sky.busy = true
			restoreRecords(saved, function() sky.busy = false end)
			setStatus("Sky restored.")
			showToast("Grey Sky: OFF")
		end
	end
	skyToggle = makeToggle(pgStyle, "Grey Sky", 8, false, setGreySky)
end

------------------------------------------------------------
-- FPS + ping chips (one cheap loop)
------------------------------------------------------------
local function readDataPing() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end
local function readPerfPing() return Stats.PerformanceStats.Ping:GetValue() end
local function readNetPing() return player:GetNetworkPing() * 2000 end

local function getPing()
	local ok, v = pcall(readDataPing)
	if ok and type(v) == "number" and v > 0 then return v end
	ok, v = pcall(readPerfPing)
	if ok and type(v) == "number" and v > 0 then return v end
	ok, v = pcall(readNetPing)
	if ok and type(v) == "number" and v > 0 then return v end
	return nil
end

local GOOD, OKAY, BAD = Color3.fromRGB(120, 255, 160), Color3.fromRGB(255, 220, 90), Color3.fromRGB(255, 100, 110)
local function colorFor(value, good, ok, lowerBetter)
	if lowerBetter then
		if value <= good then return GOOD end
		if value <= ok then return OKAY end
		return BAD
	end
	if value >= good then return GOOD end
	if value >= ok then return OKAY end
	return BAD
end

local frames, lastCount = 0, os.clock()
track(RunService.Heartbeat:Connect(function()
	frames += 1
	local now = os.clock()
	if now - lastCount < 0.5 then return end
	local fps = math.floor(frames / (now - lastCount) + 0.5)
	frames, lastCount = 0, now
	local showChips = main.Visible and fpsLabel.Visible
	if not (showChips or hudOn) then return end
	local ping = getPing()
	local pingTxt = "-- ms"
	local pingCol = C.text
	if ping then
		ping = math.floor(ping + 0.5)
		pingTxt = ping .. " ms"
		pingCol = colorFor(ping, 80, 150, true)
	end
	local fpsCol = colorFor(fps, 50, 30, false)
	if showChips then
		fpsLabel.Text = fps .. " fps"
		fpsLabel.TextColor3 = fpsCol
		pingLabel.Text = pingTxt
		pingLabel.TextColor3 = pingCol
	end
	if hudOn and hudLbl then
		hudLbl.Text = "FPS " .. fps .. "  |  " .. pingTxt
		hudLbl.TextColor3 = fpsCol
	end
end))

------------------------------------------------------------
-- Minimize / close / reopen
------------------------------------------------------------
local reopen = new("TextButton", {
	Name = "Reopen",
	Size = UDim2.fromOffset(50, 50),
	Position = UDim2.new(0, 10, 0.5, -25),
	BackgroundColor3 = C.dark,
	Text = "",
	AutoButtonColor = false,
	Visible = false,
}, gui)
corner(reopen, 25)
new("UIStroke", { Thickness = 2, Color = C.ice }, reopen)
local rLogo = makeLogo(reopen, 40)
rLogo.Position = UDim2.fromOffset(5, 5)

local sizeTween = nil
local function playSize(size, info)
	if sizeTween then sizeTween:Cancel() end
	sizeTween = TweenService:Create(main, info, { Size = size })
	sizeTween:Play()
end

local function setOpen(open)
	if open then
		reopen.Visible = false
		main.Visible = true
		main.Size = UDim2.fromOffset(W, 0)
		pcall(reclampAll)
		playSize(
			minimized and UDim2.fromOffset(W, HEADER_H) or UDim2.fromOffset(W, H),
			TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		)
	else
		if sizeTween then sizeTween:Cancel() end
		main.Visible = false
		pcall(reclampAll)
		reopen.Visible = true
	end
end

minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	playSize(
		minimized and UDim2.fromOffset(W, HEADER_H) or UDim2.fromOffset(W, H),
		TweenInfo.new(0.25, Enum.EasingStyle.Quad)
	)
	minBtn.Text = minimized and "+" or "–"
end)
closeBtn.MouseButton1Click:Connect(function() setOpen(false) end)

local reopenDrag = makeDraggable(reopen, reopen, 50, 50, nil)
reopen.Activated:Connect(function()
	if not reopenDrag.moved then setOpen(true) end
end)

local introActive = false
track(UserInputService.InputBegan:Connect(function(input, processed)
	if processed or introActive then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		setOpen(not main.Visible)
	end
end))

------------------------------------------------------------
-- Cleanup (runs automatically if the script is executed again)
------------------------------------------------------------
do
	local ok, env = pcall(function() return getgenv() end)
	if ok and type(env) == "table" then
		env.FrostUniversalCleanup = function()
			pcall(stopStretch)
			pcall(function() if boost.on then disableBoost() end end)
			pcall(function() if dark.on then setDark(false) end end)
			pcall(function()
				for p in pairs(hideSet) do setPlayerHidden(p, false) end
			end)
			pcall(function() if ultra.on then setUltra(false) end end)
			pcall(setFreezeAnims, false)
			pcall(function() if resetFonts then resetFonts() end end)
			pcall(function() if greySkyOn() then setGreySky(false) end end)
			pcall(function() if potato.on then setPotato(false) end end)
			pcall(function() if meshHide.on then setMeshHide(false) end end)
			pcall(set3d, false)
			pcall(function() if shadowConn then shadowConn:Disconnect() end end)
			for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
			for _, f in ipairs(cleanups) do pcall(f) end
			pcall(function() gui:Destroy() end)
		end
	end
end

------------------------------------------------------------
-- Intro: icy "FROST HUBZ" (snow, freezing edges, shimmer). Tap to skip.
------------------------------------------------------------
function playIntro(onDone)
	if not CONFIG.ShowIntro then
		onDone()
		return
	end
	introActive = true
	local done = false

	local overlay = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(4, 10, 24),
		BorderSizePixel = 0,
		Active = true,
		ClipsDescendants = true,
		ZIndex = 100,
	}, gui)
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(8, 22, 50), Color3.fromRGB(2, 6, 16)),
		Rotation = 90,
	}, overlay)

	-- icy edges that "freeze" inward
	local function edge(pos, anchor, size0, size1, rot)
		local f = new("Frame", {
			AnchorPoint = anchor, Position = pos, Size = size0,
			BackgroundColor3 = Color3.fromRGB(170, 225, 255),
			BorderSizePixel = 0, ZIndex = 101,
		}, overlay)
		new("UIGradient", {
			Rotation = rot,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.3),
				NumberSequenceKeypoint.new(1, 1),
			}),
		}, f)
		TweenService:Create(f, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = size1 }):Play()
	end
	edge(UDim2.fromScale(0, 0), Vector2.new(0, 0), UDim2.new(1, 0, 0, 0), UDim2.new(1, 0, 0, 90), 90)
	edge(UDim2.fromScale(0, 1), Vector2.new(0, 1), UDim2.new(1, 0, 0, 0), UDim2.new(1, 0, 0, 90), 270)
	edge(UDim2.fromScale(0, 0), Vector2.new(0, 0), UDim2.new(0, 0, 1, 0), UDim2.new(0, 90, 1, 0), 0)
	edge(UDim2.fromScale(1, 0), Vector2.new(1, 0), UDim2.new(0, 0, 1, 0), UDim2.new(0, 90, 1, 0), 180)

	-- falling snow
	local flakes = {}
	for i = 1, 26 do
		local s = math.random(2, 5)
		local f = new("Frame", {
			Size = UDim2.fromOffset(s, s),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = math.random(30, 70) / 100,
			BorderSizePixel = 0, ZIndex = 102,
		}, overlay)
		new("UICorner", { CornerRadius = UDim.new(1, 0) }, f)
		flakes[i] = {
			f = f, x = math.random(), y = math.random(),
			v = 0.05 + math.random() * 0.12, ph = math.random() * 6,
		}
	end
	local t0 = os.clock()
	local snowConn = RunService.Heartbeat:Connect(function(dt)
		local t = os.clock() - t0
		for _, p in ipairs(flakes) do
			p.y += p.v * dt
			if p.y > 1.05 then p.y = -0.05 end
			p.f.Position = UDim2.fromScale(p.x + math.sin(t * 1.3 + p.ph) * 0.012, p.y)
		end
	end)

	-- soft glow + snowman
	local glow = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -34),
		Size = UDim2.fromOffset(0, 0),
		BackgroundColor3 = Color3.fromRGB(120, 200, 255),
		BackgroundTransparency = 0.78,
		BorderSizePixel = 0, ZIndex = 102,
	}, overlay)
	new("UICorner", { CornerRadius = UDim.new(1, 0) }, glow)
	local logo = makeLogo(overlay, 84)
	logo.AnchorPoint = Vector2.new(0.5, 0.5)
	logo.Position = UDim2.new(0.5, 0, 0.5, -34)
	logo.Size = UDim2.fromOffset(0, 0)
	logo.ZIndex = 103

	-- title freezes in, then a shine sweeps across it
	local title = new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 38),
		Size = UDim2.fromOffset(420, 46),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack,
		TextSize = 32,
		Text = "FROST UNIVERSAL",
		TextColor3 = Color3.new(1, 1, 1),
		TextTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 104,
	}, overlay)
	new("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.55, Color3.fromRGB(150, 220, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 240, 255)),
		}),
		Rotation = 90,
	}, title)
	local tStroke = new("UIStroke", { Thickness = 6, Color = Color3.fromRGB(120, 210, 255), Transparency = 1 }, title)
	local shine = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(-0.2, 0, 0.5, 0),
		Size = UDim2.fromOffset(26, 90),
		Rotation = 20,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0, ZIndex = 105,
	}, title)

	local sub = new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 74),
		Size = UDim2.fromOffset(300, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		Text = "O P T I M I Z E D   B Y   F R O S T",
		TextColor3 = Color3.fromRGB(140, 220, 255),
		TextTransparency = 1,
		ZIndex = 104,
	}, overlay)

	local track0 = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 98),
		Size = UDim2.fromOffset(150, 4),
		BackgroundColor3 = Color3.fromRGB(20, 40, 70),
		BorderSizePixel = 0, ZIndex = 104,
	}, overlay)
	new("UICorner", { CornerRadius = UDim.new(1, 0) }, track0)
	local fill = new("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0, ZIndex = 105,
	}, track0)
	new("UICorner", { CornerRadius = UDim.new(1, 0) }, fill)
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(80, 170, 255), Color3.fromRGB(210, 245, 255)),
	}, fill)

	local skip = new("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 110,
	}, overlay)

	-- timeline
	TweenService:Create(glow, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(190, 190), BackgroundTransparency = 0.9,
	}):Play()
	TweenService:Create(logo, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(84, 84),
	}):Play()
	task.delay(0.35, function()
		if done then return end
		TweenService:Create(title, TweenInfo.new(0.6, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()
		tStroke.Transparency = 0.3
		TweenService:Create(tStroke, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Thickness = 1.5, Transparency = 0.5,
		}):Play()
	end)
	task.delay(0.9, function()
		if done then return end
		TweenService:Create(shine, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {
			Position = UDim2.new(1.2, 0, 0.5, 0),
		}):Play()
		TweenService:Create(sub, TweenInfo.new(0.5), { TextTransparency = 0.1 }):Play()
	end)
	TweenService:Create(fill, TweenInfo.new(2.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Size = UDim2.fromScale(1, 1),
	}):Play()

	local function finish()
		if done then return end
		done = true
		snowConn:Disconnect()
		-- fade everything out together, open the hub while it fades
		local fo = TweenInfo.new(0.35)
		for _, d in ipairs(overlay:GetDescendants()) do
			if d:IsA("TextLabel") then
				TweenService:Create(d, fo, { TextTransparency = 1 }):Play()
			elseif d:IsA("ImageLabel") then
				TweenService:Create(d, fo, { ImageTransparency = 1, BackgroundTransparency = 1 }):Play()
			elseif d:IsA("Frame") then
				TweenService:Create(d, fo, { BackgroundTransparency = 1 }):Play()
			elseif d:IsA("UIStroke") then
				TweenService:Create(d, fo, { Transparency = 1 }):Play()
			end
		end
		TweenService:Create(overlay, fo, { BackgroundTransparency = 1 }):Play()
		task.delay(0.15, function()
			introActive = false
			onDone()
		end)
		task.delay(0.4, function() overlay:Destroy() end)
	end
	skip.Activated:Connect(finish)
	task.delay(2.8, finish)
end

------------------------------------------------------------
-- Start
------------------------------------------------------------
selectPage(1)
playIntro(function()
	setOpen(true)
	for _, f in ipairs(onReady) do pcall(f) end
	showToast("Welcome to Frost UNIVERSAL")
end)
