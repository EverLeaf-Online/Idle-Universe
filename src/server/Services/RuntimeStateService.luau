--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Machines = require(ReplicatedStorage.Shared.Config.Machines)

export type PlayerState = {
	Credits: number,
	LifetimeCredits: number,
	RecyclerAutomated: boolean,
	MachineLevels: { [string]: number },
}

local RuntimeStateService = {}
local states: { [Player]: PlayerState } = {}
local initialized = false

local function createDefaultState(): PlayerState
	local machineLevels: { [string]: number } = {}

	for machineId, definition in Machines do
		machineLevels[machineId] = if definition.StartsOwned then 1 else 0
	end

	return {
		Credits = 0,
		LifetimeCredits = 0,
		RecyclerAutomated = false,
		MachineLevels = machineLevels,
	}
end

function RuntimeStateService.Init()
	assert(not initialized, "RuntimeStateService.Init called more than once")
	initialized = true

	for _, player in Players:GetPlayers() do
		states[player] = createDefaultState()
	end

	Players.PlayerAdded:Connect(function(player)
		states[player] = createDefaultState()
	end)

	Players.PlayerRemoving:Connect(function(player)
		states[player] = nil
	end)
end

function RuntimeStateService.GetState(player: Player): PlayerState
	local state = states[player]
	assert(state ~= nil, string.format("No runtime state for player %s", player.Name))
	return state
end

return RuntimeStateService
