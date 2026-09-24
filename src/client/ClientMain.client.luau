--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteNames = require(ReplicatedStorage.Shared.RemoteNames)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") :: PlayerGui
local remotes = ReplicatedStorage:WaitForChild(RemoteNames.Folder)

local manualScrapRemote = remotes:WaitForChild(RemoteNames.ManualScrap) :: RemoteEvent
local automateRecyclerRemote = remotes:WaitForChild(RemoteNames.AutomateRecycler) :: RemoteEvent
local purchaseMachineLevelRemote = remotes:WaitForChild(RemoteNames.PurchaseMachineLevel) :: RemoteEvent
local getStateRemote = remotes:WaitForChild(RemoteNames.GetState) :: RemoteFunction
local stateUpdatedRemote = remotes:WaitForChild(RemoteNames.StateUpdated) :: RemoteEvent

type Snapshot = {
	Credits: number,
	LifetimeCredits: number,
	IncomePerSecond: number,
	RecyclerAutomated: boolean,
	AutomationCost: number,
	ManualScrapReward: number,
	MachineLevels: {
		ScrapRecycler: number,
		IndustrialSmelter: number,
	},
	NextLevelCosts: {
		ScrapRecycler: number,
		IndustrialSmelter: number,
	},
}

local function formatNumber(value: number): string
	local absolute = math.abs(value)
	local suffixes = {
		{ 1e12, "T" },
		{ 1e9, "B" },
		{ 1e6, "M" },
		{ 1e3, "K" },
	}

	for _, entry in suffixes do
		local threshold = entry[1] :: number
		local suffix = entry[2] :: string
		if absolute >= threshold then
			return string.format("%.2f%s", value / threshold, suffix)
		end
	end

	if value >= 100 then
		return string.format("%.0f", value)
	end

	return string.format("%.1f", value)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "IdleUniverseGreybox"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.fromOffset(360, 430)
panel.Position = UDim2.new(0.5, -180, 0.5, -215)
panel.Parent = screenGui

local function createLabel(name: string, y: number, height: number, textSize: number): TextLabel
	local label = Instance.new("TextLabel")
	label.Name = name
	label.Size = UDim2.new(1, -24, 0, height)
	label.Position = UDim2.fromOffset(12, y)
	label.BackgroundTransparency = 1
	label.TextSize = textSize
	label.TextWrapped = true
	label.Parent = panel
	return label
end

local function createButton(name: string, y: number): TextButton
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, -24, 0, 48)
	button.Position = UDim2.fromOffset(12, y)
	button.TextSize = 18
	button.TextWrapped = true
	button.Parent = panel
	return button
end

local titleLabel = createLabel("Title", 10, 34, 26)
titleLabel.Text = "Idle Universe — Earth Greybox"

local creditsLabel = createLabel("Credits", 52, 30, 24)
local incomeLabel = createLabel("Income", 84, 26, 19)
local statusLabel = createLabel("Status", 112, 34, 17)

local manualButton = createButton("ManualScrap", 154)
local automateButton = createButton("AutomateRecycler", 210)
local recyclerButton = createButton("UpgradeRecycler", 266)
local smelterButton = createButton("UpgradeSmelter", 322)

local hintLabel = createLabel("Hint", 380, 38, 14)
hintLabel.Text = "Greybox only: progression is server-authoritative and resets when the server closes."

local function render(snapshot: Snapshot)
	creditsLabel.Text = string.format("Credits: %s", formatNumber(snapshot.Credits))
	incomeLabel.Text = string.format("Income/sec: %s", formatNumber(snapshot.IncomePerSecond))

	if snapshot.RecyclerAutomated then
		statusLabel.Text = "Recycler automation online. Upgrade the line and build the Smelter."
	else
		statusLabel.Text = "Feed scrap manually, then automate the Recycler."
	end

	manualButton.Text = string.format("Process Scrap (+%s Credits)", formatNumber(snapshot.ManualScrapReward))

	automateButton.Visible = not snapshot.RecyclerAutomated
	automateButton.Text = string.format(
		"Automate Recycler — %s Credits",
		formatNumber(snapshot.AutomationCost)
	)

	recyclerButton.Visible = snapshot.RecyclerAutomated
	recyclerButton.Text = string.format(
		"Upgrade Recycler L%d → %s Credits",
		snapshot.MachineLevels.ScrapRecycler,
		formatNumber(snapshot.NextLevelCosts.ScrapRecycler)
	)

	smelterButton.Visible = snapshot.RecyclerAutomated
	if snapshot.MachineLevels.IndustrialSmelter == 0 then
		smelterButton.Text = string.format(
			"Build Industrial Smelter — %s Credits",
			formatNumber(snapshot.NextLevelCosts.IndustrialSmelter)
		)
	else
		smelterButton.Text = string.format(
			"Upgrade Smelter L%d → %s Credits",
			snapshot.MachineLevels.IndustrialSmelter,
			formatNumber(snapshot.NextLevelCosts.IndustrialSmelter)
		)
	end
end

manualButton.Activated:Connect(function()
	manualScrapRemote:FireServer()
end)

automateButton.Activated:Connect(function()
	automateRecyclerRemote:FireServer()
end)

recyclerButton.Activated:Connect(function()
	purchaseMachineLevelRemote:FireServer("ScrapRecycler")
end)

smelterButton.Activated:Connect(function()
	purchaseMachineLevelRemote:FireServer("IndustrialSmelter")
end)

stateUpdatedRemote.OnClientEvent:Connect(function(snapshot: Snapshot)
	render(snapshot)
end)

local initialSnapshot = getStateRemote:InvokeServer() :: Snapshot
render(initialSnapshot)
