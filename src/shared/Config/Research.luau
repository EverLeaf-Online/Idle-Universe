--!strict

export type ResearchBranch = "Production" | "Logistics" | "Science" | "Efficiency"

export type ResearchModifier = {
	Kind: string,
	Value: number,
}

export type ResearchNode = {
	Id: string,
	DisplayName: string,
	Branch: ResearchBranch,
	Cost: number,
	Prerequisites: { string },
	Modifiers: { ResearchModifier },
}

local Research: { [string]: ResearchNode } = {
	EfficientMotors = {
		Id = "EfficientMotors",
		DisplayName = "Efficient Motors",
		Branch = "Production",
		Cost = 5,
		Prerequisites = {},
		Modifiers = {
			{ Kind = "GlobalCreditProduction", Value = 0.10 },
		},
	},

	RefinedProcessing = {
		Id = "RefinedProcessing",
		DisplayName = "Refined Processing",
		Branch = "Production",
		Cost = 15,
		Prerequisites = { "EfficientMotors" },
		Modifiers = {
			{ Kind = "EarlyMachineProduction", Value = 0.25 },
		},
	},

	ParallelManufacturing = {
		Id = "ParallelManufacturing",
		DisplayName = "Parallel Manufacturing",
		Branch = "Production",
		Cost = 40,
		Prerequisites = { "RefinedProcessing" },
		Modifiers = {
			{ Kind = "MilestoneBonusStrength", Value = 0.15 },
		},
	},

	HighEnergyIndustry = {
		Id = "HighEnergyIndustry",
		DisplayName = "High-Energy Industry",
		Branch = "Production",
		Cost = 100,
		Prerequisites = { "ParallelManufacturing" },
		Modifiers = {
			{ Kind = "HighEnergyProduction", Value = 0.30 },
		},
	},

	StellarEngineering = {
		Id = "StellarEngineering",
		DisplayName = "Stellar Engineering",
		Branch = "Production",
		Cost = 250,
		Prerequisites = { "HighEnergyIndustry" },
		Modifiers = {
			{ Kind = "DysonFoundryProduction", Value = 0.40 },
		},
	},

	ConveyorOptimization = {
		Id = "ConveyorOptimization",
		DisplayName = "Conveyor Optimization",
		Branch = "Logistics",
		Cost = 5,
		Prerequisites = {},
		Modifiers = {
			{ Kind = "EarlyMachineProduction", Value = 0.10 },
		},
	},

	OrbitalLogistics = {
		Id = "OrbitalLogistics",
		DisplayName = "Orbital Logistics",
		Branch = "Logistics",
		Cost = 20,
		Prerequisites = { "ConveyorOptimization" },
		Modifiers = {},
	},

	AutonomousRouting = {
		Id = "AutonomousRouting",
		DisplayName = "Autonomous Routing",
		Branch = "Logistics",
		Cost = 50,
		Prerequisites = { "OrbitalLogistics" },
		Modifiers = {
			{ Kind = "MachineCostReduction", Value = 0.05 },
		},
	},

	DeepSpaceLogistics = {
		Id = "DeepSpaceLogistics",
		DisplayName = "Deep-Space Logistics",
		Branch = "Logistics",
		Cost = 150,
		Prerequisites = { "AutonomousRouting" },
		Modifiers = {},
	},

	SolarSupplyChain = {
		Id = "SolarSupplyChain",
		DisplayName = "Solar Supply Chain",
		Branch = "Logistics",
		Cost = 400,
		Prerequisites = { "DeepSpaceLogistics" },
		Modifiers = {
			{ Kind = "LateMachineCostReduction", Value = 0.05 },
		},
	},

	AppliedMetallurgy = {
		Id = "AppliedMetallurgy",
		DisplayName = "Applied Metallurgy",
		Branch = "Science",
		Cost = 8,
		Prerequisites = {},
		Modifiers = {
			{ Kind = "ResearchProduction", Value = 0.15 },
		},
	},

	Robotics = {
		Id = "Robotics",
		DisplayName = "Robotics",
		Branch = "Science",
		Cost = 30,
		Prerequisites = { "AppliedMetallurgy" },
		Modifiers = {
			{ Kind = "RobotFactoryProduction", Value = 0.25 },
		},
	},

	Nanotechnology = {
		Id = "Nanotechnology",
		DisplayName = "Nanotechnology",
		Branch = "Science",
		Cost = 80,
		Prerequisites = { "Robotics" },
		Modifiers = {
			{ Kind = "NanoFabricatorProduction", Value = 0.25 },
		},
	},

	AntimatterContainment = {
		Id = "AntimatterContainment",
		DisplayName = "Antimatter Containment",
		Branch = "Science",
		Cost = 220,
		Prerequisites = { "Nanotechnology" },
		Modifiers = {
			{ Kind = "AntimatterReactorProduction", Value = 0.25 },
		},
	},

	RealityTheory = {
		Id = "RealityTheory",
		DisplayName = "Reality Theory",
		Branch = "Science",
		Cost = 600,
		Prerequisites = { "AntimatterContainment" },
		Modifiers = {},
	},

	BulkPurchasing = {
		Id = "BulkPurchasing",
		DisplayName = "Bulk Purchasing",
		Branch = "Efficiency",
		Cost = 5,
		Prerequisites = {},
		Modifiers = {
			{ Kind = "MachineCostReduction", Value = 0.03 },
		},
	},

	EnergyRecovery = {
		Id = "EnergyRecovery",
		DisplayName = "Energy Recovery",
		Branch = "Efficiency",
		Cost = 20,
		Prerequisites = { "BulkPurchasing" },
		Modifiers = {
			{ Kind = "HighTierProduction", Value = 0.15 },
		},
	},

	ResearchOptimization = {
		Id = "ResearchOptimization",
		DisplayName = "Research Optimization",
		Branch = "Efficiency",
		Cost = 60,
		Prerequisites = { "EnergyRecovery" },
		Modifiers = {
			{ Kind = "ResearchProduction", Value = 0.25 },
		},
	},

	IndustrialCompression = {
		Id = "IndustrialCompression",
		DisplayName = "Industrial Compression",
		Branch = "Efficiency",
		Cost = 160,
		Prerequisites = { "ResearchOptimization" },
		Modifiers = {
			{ Kind = "MachineCostReduction", Value = 0.07 },
		},
	},

	SingularityPreparation = {
		Id = "SingularityPreparation",
		DisplayName = "Singularity Preparation",
		Branch = "Efficiency",
		Cost = 450,
		Prerequisites = { "IndustrialCompression" },
		Modifiers = {
			{ Kind = "RealityEngineContribution", Value = 0.20 },
		},
	},
}

return table.freeze(Research)
