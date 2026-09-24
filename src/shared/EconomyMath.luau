--!strict

local Machines = require(script.Parent.Config.Machines)
local Prestige = require(script.Parent.Config.Prestige)

local EconomyMath = {}

local function getMachine(machineId: string)
	local machine = Machines[machineId]
	assert(machine ~= nil, string.format("Unknown machine id: %s", machineId))
	return machine
end

function EconomyMath.GetMilestoneMultiplier(machineId: string, level: number): number
	assert(level >= 0, "level must be non-negative")

	local machine = getMachine(machineId)
	local multiplier = 1

	for _, milestone in machine.Milestones do
		if level >= milestone.Level then
			multiplier *= milestone.Multiplier
		end
	end

	return multiplier
end

function EconomyMath.GetNextLevelCost(
	machineId: string,
	currentLevel: number,
	costMultiplier: number?
): number
	assert(currentLevel >= 0, "currentLevel must be non-negative")

	local machine = getMachine(machineId)
	local modifier = costMultiplier or 1
	assert(modifier > 0, "costMultiplier must be positive")

	local rawCost = machine.BaseCost * (machine.CostGrowth ^ currentLevel) * modifier
	return math.max(1, math.ceil(rawCost))
end

function EconomyMath.GetBaseProductionPerSecond(machineId: string, level: number): number
	assert(level >= 0, "level must be non-negative")

	if level == 0 then
		return 0
	end

	local machine = getMachine(machineId)
	return machine.BaseOutputPerSecond
		* level
		* EconomyMath.GetMilestoneMultiplier(machineId, level)
end

function EconomyMath.GetProductionPerSecond(
	machineId: string,
	level: number,
	productionMultiplier: number?
): number
	local modifier = productionMultiplier or 1
	assert(modifier >= 0, "productionMultiplier must be non-negative")

	return EconomyMath.GetBaseProductionPerSecond(machineId, level) * modifier
end

function EconomyMath.GetCoreReward(currentRunLifetimeCredits: number): number
	assert(currentRunLifetimeCredits >= 0, "currentRunLifetimeCredits must be non-negative")

	local scale = Prestige.Singularity.CoreRewardScale
	local rawReward = math.floor(math.sqrt(currentRunLifetimeCredits / scale))
	return math.max(1, rawReward)
end

function EconomyMath.GetOfflineReward(
	productionPerSecond: number,
	elapsedSeconds: number,
	efficiency: number,
	maximumDurationSeconds: number
): number
	assert(productionPerSecond >= 0, "productionPerSecond must be non-negative")
	assert(elapsedSeconds >= 0, "elapsedSeconds must be non-negative")
	assert(efficiency >= 0, "efficiency must be non-negative")
	assert(maximumDurationSeconds >= 0, "maximumDurationSeconds must be non-negative")

	local boundedSeconds = math.min(elapsedSeconds, maximumDurationSeconds)
	return productionPerSecond * boundedSeconds * efficiency
end

return table.freeze(EconomyMath)
