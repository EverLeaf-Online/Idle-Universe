--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteNames = require(ReplicatedStorage.Shared.RemoteNames)
local RuntimeStateService = require(script.Parent.Services.RuntimeStateService)
local EconomyService = require(script.Parent.Services.EconomyService)
local MachineService = require(script.Parent.Services.MachineService)

local function getOrCreateFolder(parent: Instance, name: string): Folder
	local existing = parent:FindFirstChild(name)
	if existing ~= nil then
		assert(existing:IsA("Folder"), string.format("%s must be a Folder", name))
		return existing
	end

	local folder = Instance.new("Folder")
	folder.Name = name
	folder.Parent = parent
	return folder
end

local function getOrCreateRemoteEvent(parent: Instance, name: string): RemoteEvent
	local existing = parent:FindFirstChild(name)
	if existing ~= nil then
		assert(existing:IsA("RemoteEvent"), string.format("%s must be a RemoteEvent", name))
		return existing
	end

	local remote = Instance.new("RemoteEvent")
	remote.Name = name
	remote.Parent = parent
	return remote
end

local function getOrCreateRemoteFunction(parent: Instance, name: string): RemoteFunction
	local existing = parent:FindFirstChild(name)
	if existing ~= nil then
		assert(existing:IsA("RemoteFunction"), string.format("%s must be a RemoteFunction", name))
		return existing
	end

	local remote = Instance.new("RemoteFunction")
	remote.Name = name
	remote.Parent = parent
	return remote
end

RuntimeStateService.Init()

local remotesFolder = getOrCreateFolder(ReplicatedStorage, RemoteNames.Folder)
local manualScrapRemote = getOrCreateRemoteEvent(remotesFolder, RemoteNames.ManualScrap)
local automateRecyclerRemote = getOrCreateRemoteEvent(remotesFolder, RemoteNames.AutomateRecycler)
local purchaseMachineLevelRemote = getOrCreateRemoteEvent(remotesFolder, RemoteNames.PurchaseMachineLevel)
local getStateRemote = getOrCreateRemoteFunction(remotesFolder, RemoteNames.GetState)
local stateUpdatedRemote = getOrCreateRemoteEvent(remotesFolder, RemoteNames.StateUpdated)

local function pushState(player: Player)
	stateUpdatedRemote:FireClient(player, MachineService.GetSnapshot(player))
end

getStateRemote.OnServerInvoke = function(player: Player)
	return MachineService.GetSnapshot(player)
end

manualScrapRemote.OnServerEvent:Connect(function(player: Player)
	if MachineService.ManualScrap(player) then
		pushState(player)
	end
end)

automateRecyclerRemote.OnServerEvent:Connect(function(player: Player)
	if MachineService.AutomateRecycler(player) then
		pushState(player)
	end
end)

purchaseMachineLevelRemote.OnServerEvent:Connect(function(player: Player, machineId: unknown)
	if typeof(machineId) ~= "string" then
		return
	end

	if MachineService.PurchaseMachineLevel(player, machineId) then
		pushState(player)
	end
end)

-- Greybox production heartbeat. Persistence and modifier systems will replace
-- this minimal loop as later roadmap phases are implemented.
task.spawn(function()
	local previous = os.clock()

	while true do
		task.wait(0.25)

		local now = os.clock()
		local deltaTime = math.min(now - previous, 1)
		previous = now

		for _, player in Players:GetPlayers() do
			EconomyService.ProduceForPlayer(player, deltaTime)
			pushState(player)
		end
	end
end)
