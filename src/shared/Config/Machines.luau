--!strict

export type CurrencyId = "Credits" | "Research"

export type Milestone = {
	Level: number,
	Multiplier: number,
}

export type MachineDefinition = {
	Id: string,
	DisplayName: string,
	WorldId: string,
	Currency: CurrencyId,
	BaseCost: number,
	CostGrowth: number,
	BaseOutputPerSecond: number,
	Milestones: { Milestone },
	StartsOwned: boolean?,
	AutomationCost: number?,
}

local STANDARD_MILESTONES: { Milestone } = {
	{ Level = 10, Multiplier = 2 },
	{ Level = 25, Multiplier = 2 },
	{ Level = 50, Multiplier = 3 },
	{ Level = 100, Multiplier = 5 },
	{ Level = 250, Multiplier = 10 },
}

local function milestones(): { Milestone }
	local copy = table.create(#STANDARD_MILESTONES)
	for index, value in STANDARD_MILESTONES do
		copy[index] = {
			Level = value.Level,
			Multiplier = value.Multiplier,
		}
	end
	return copy
end

local Machines: { [string]: MachineDefinition } = {
	ScrapRecycler = {
		Id = "ScrapRecycler",
		DisplayName = "Scrap Recycler",
		WorldId = "EarthScrapyard",
		Currency = "Credits",
		BaseCost = 50,
		CostGrowth = 1.14,
		BaseOutputPerSecond = 1,
		Milestones = milestones(),
		StartsOwned = true,
		AutomationCost = 75,
	},

	IndustrialSmelter = {
		Id = "IndustrialSmelter",
		DisplayName = "Industrial Smelter",
		WorldId = "EarthScrapyard",
		Currency = "Credits",
		BaseCost = 500,
		CostGrowth = 1.15,
		BaseOutputPerSecond = 12,
		Milestones = milestones(),
	},

	AssemblyLine = {
		Id = "AssemblyLine",
		DisplayName = "Assembly Line",
		WorldId = "LunarIndustrialComplex",
		Currency = "Credits",
		BaseCost = 20000,
		CostGrowth = 1.15,
		BaseOutputPerSecond = 500,
		Milestones = milestones(),
	},

	ResearchLab = {
		Id = "ResearchLab",
		DisplayName = "Research Lab",
		WorldId = "LunarIndustrialComplex",
		Currency = "Research",
		BaseCost = 50000,
		CostGrowth = 1.16,
		BaseOutputPerSecond = 0.5,
		Milestones = milestones(),
	},

	RobotFactory = {
		Id = "RobotFactory",
		DisplayName = "Robot Factory",
		WorldId = "MarsFoundry",
		Currency = "Credits",
		BaseCost = 1000000,
		CostGrowth = 1.16,
		BaseOutputPerSecond = 30000,
		Milestones = milestones(),
	},

	FusionReactor = {
		Id = "FusionReactor",
		DisplayName = "Fusion Reactor",
		WorldId = "MarsFoundry",
		Currency = "Credits",
		BaseCost = 10000000,
		CostGrowth = 1.17,
		BaseOutputPerSecond = 300000,
		Milestones = milestones(),
	},

	NanoFabricator = {
		Id = "NanoFabricator",
		DisplayName = "Nano Fabricator",
		WorldId = "AsteroidNexus",
		Currency = "Credits",
		BaseCost = 500000000,
		CostGrowth = 1.17,
		BaseOutputPerSecond = 15000000,
		Milestones = milestones(),
	},

	AntimatterReactor = {
		Id = "AntimatterReactor",
		DisplayName = "Antimatter Reactor",
		WorldId = "AsteroidNexus",
		Currency = "Credits",
		BaseCost = 5000000000,
		CostGrowth = 1.18,
		BaseOutputPerSecond = 175000000,
		Milestones = milestones(),
	},

	DysonFoundry = {
		Id = "DysonFoundry",
		DisplayName = "Dyson Foundry",
		WorldId = "SolarForge",
		Currency = "Credits",
		BaseCost = 200000000000,
		CostGrowth = 1.18,
		BaseOutputPerSecond = 7000000000,
		Milestones = milestones(),
	},

	RealityEngine = {
		Id = "RealityEngine",
		DisplayName = "Reality Engine",
		WorldId = "SolarForge",
		Currency = "Credits",
		BaseCost = 2000000000000,
		CostGrowth = 1.20,
		BaseOutputPerSecond = 90000000000,
		Milestones = milestones(),
	},
}

return table.freeze(Machines)
