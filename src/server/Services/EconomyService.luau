--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Machines = require(ReplicatedStorage.Shared.Config.Machines)
local EconomyMath = require(ReplicatedStorage.Shared.EconomyMath)
local RuntimeStateService = require(script.Parent.RuntimeStateService)

local EconomyService = {}

function EconomyService.AwardCredits(player: Player, amount: number)
	assert(amount >= 0 and amount < math.huge, "invalid credit award")

	local state = RuntimeStateService.GetState(player)
	state.Credits += amount
	state.LifetimeCredits += amount
end

function EconomyService.SpendCredits(player: Player, amount: number): boolean
	assert(amount >= 0 and amount < math.huge, "invalid credit spend")

	local state = RuntimeStateService.GetState(player)
	if state.Credits < amount then
		return false
	end

	state.Credits -= amount
	return true
end

function EconomyService.GetCreditIncomePerSecond(player: Player): number
	local state = RuntimeStateService.GetState(player)
	if not state.RecyclerAutomated then
		return 0
	end

	local total = 0
	for machineId, level in state.MachineLevels do
		local definition = Machines[machineId]
		if definition ~= nil and definition.Currency == "Credits" then
			total += EconomyMath.GetBaseProductionPerSecond(machineId, level)
		end
	end

	return total
end

function EconomyService.ProduceForPlayer(player: Player, deltaTime: number)
	assert(deltaTime >= 0, "deltaTime must be non-negative")

	local incomePerSecond = EconomyService.GetCreditIncomePerSecond(player)
	if incomePerSecond <= 0 then
		return
	end

	EconomyService.AwardCredits(player, incomePerSecond * deltaTime)
end

return EconomyService
