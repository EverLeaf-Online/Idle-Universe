--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Machines = require(ReplicatedStorage.Shared.Config.Machines)
local EconomyMath = require(ReplicatedStorage.Shared.EconomyMath)
local RuntimeStateService = require(script.Parent.RuntimeStateService)
local EconomyService = require(script.Parent.EconomyService)

local MachineService = {}

local MANUAL_SCRAP_REWARD = 2
local MANUAL_SCRAP_COOLDOWN = 0.95
local PURCHASE_COOLDOWN = 0.08
local AUTOMATION_COOLDOWN = 0.25

local GREYBOX_MACHINE_IDS: { [string]: boolean } = {
	ScrapRecycler = true,
	IndustrialSmelter = true,
}

local lastActions: { [Player]: { [string]: number } } = {}

local function passesRateLimit(player: Player, key: string, cooldown: number): boolean
	local now = os.clock()
	local playerActions = lastActions[player]
	if playerActions == nil then
		playerActions = {}
		lastActions[player] = playerActions
	end

	local previous = playerActions[key] or -math.huge
	if now - previous < cooldown then
		return false
	end

	playerActions[key] = now
	return true
end

Players.PlayerRemoving:Connect(function(player)
	lastActions[player] = nil
end)

function MachineService.ManualScrap(player: Player): boolean
	if not passesRateLimit(player, "ManualScrap", MANUAL_SCRAP_COOLDOWN) then
		return false
	end

	EconomyService.AwardCredits(player, MANUAL_SCRAP_REWARD)
	return true
end

function MachineService.AutomateRecycler(player: Player): boolean
	if not passesRateLimit(player, "AutomateRecycler", AUTOMATION_COOLDOWN) then
		return false
	end

	local state = RuntimeStateService.GetState(player)
	if state.RecyclerAutomated then
		return false
	end

	local automationCost = Machines.ScrapRecycler.AutomationCost
	assert(automationCost ~= nil, "ScrapRecycler is missing AutomationCost")

	if not EconomyService.SpendCredits(player, automationCost) then
		return false
	end

	state.RecyclerAutomated = true
	return true
end

function MachineService.PurchaseMachineLevel(player: Player, machineId: string): boolean
	if not GREYBOX_MACHINE_IDS[machineId] then
		return false
	end

	if not passesRateLimit(player, "PurchaseMachineLevel", PURCHASE_COOLDOWN) then
		return false
	end

	local state = RuntimeStateService.GetState(player)
	if not state.RecyclerAutomated then
		return false
	end

	local currentLevel = state.MachineLevels[machineId]
	if currentLevel == nil then
		return false
	end

	local price = EconomyMath.GetNextLevelCost(machineId, currentLevel)
	if not EconomyService.SpendCredits(player, price) then
		return false
	end

	state.MachineLevels[machineId] = currentLevel + 1
	return true
end

function MachineService.GetSnapshot(player: Player)
	local state = RuntimeStateService.GetState(player)
	local automationCost = Machines.ScrapRecycler.AutomationCost
	assert(automationCost ~= nil, "ScrapRecycler is missing AutomationCost")

	local recyclerLevel = state.MachineLevels.ScrapRecycler or 0
	local smelterLevel = state.MachineLevels.IndustrialSmelter or 0

	return {
		Credits = state.Credits,
		LifetimeCredits = state.LifetimeCredits,
		IncomePerSecond = EconomyService.GetCreditIncomePerSecond(player),
		RecyclerAutomated = state.RecyclerAutomated,
		AutomationCost = automationCost,
		ManualScrapReward = MANUAL_SCRAP_REWARD,
		MachineLevels = {
			ScrapRecycler = recyclerLevel,
			IndustrialSmelter = smelterLevel,
		},
		NextLevelCosts = {
			ScrapRecycler = EconomyMath.GetNextLevelCost("ScrapRecycler", recyclerLevel),
			IndustrialSmelter = EconomyMath.GetNextLevelCost("IndustrialSmelter", smelterLevel),
		},
	}
end

return MachineService
