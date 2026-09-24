--!strict

export type WorldDefinition = {
	Id: string,
	DisplayName: string,
	Order: number,
	UnlockCost: number,
	LifetimeCreditsRequired: number,
	RequiredMachineLevels: { [string]: number },
	RequiredResearchNodes: { string },
}

local Worlds: { [string]: WorldDefinition } = {
	EarthScrapyard = {
		Id = "EarthScrapyard",
		DisplayName = "Earth Scrapyard",
		Order = 1,
		UnlockCost = 0,
		LifetimeCreditsRequired = 0,
		RequiredMachineLevels = {},
		RequiredResearchNodes = {},
	},

	LunarIndustrialComplex = {
		Id = "LunarIndustrialComplex",
		DisplayName = "Lunar Industrial Complex",
		Order = 2,
		UnlockCost = 10000,
		LifetimeCreditsRequired = 25000,
		RequiredMachineLevels = {
			ScrapRecycler = 25,
			IndustrialSmelter = 10,
		},
		RequiredResearchNodes = {},
	},

	MarsFoundry = {
		Id = "MarsFoundry",
		DisplayName = "Mars Foundry",
		Order = 3,
		UnlockCost = 500000,
		LifetimeCreditsRequired = 2500000,
		RequiredMachineLevels = {
			AssemblyLine = 20,
		},
		RequiredResearchNodes = {
			"OrbitalLogistics",
		},
	},

	AsteroidNexus = {
		Id = "AsteroidNexus",
		DisplayName = "Asteroid Nexus",
		Order = 4,
		UnlockCost = 25000000,
		LifetimeCreditsRequired = 350000000,
		RequiredMachineLevels = {
			RobotFactory = 20,
			FusionReactor = 10,
		},
		RequiredResearchNodes = {
			"Robotics",
			"DeepSpaceLogistics",
		},
	},

	SolarForge = {
		Id = "SolarForge",
		DisplayName = "Solar Forge",
		Order = 5,
		UnlockCost = 1000000000,
		LifetimeCreditsRequired = 175000000000,
		RequiredMachineLevels = {
			NanoFabricator = 20,
			AntimatterReactor = 10,
		},
		RequiredResearchNodes = {
			"AntimatterContainment",
			"SolarSupplyChain",
			"StellarEngineering",
		},
	},
}

return table.freeze(Worlds)
