--!strict

export type CoreNode = {
	Id: string,
	DisplayName: string,
	Branch: string,
	Cost: number,
	Prerequisites: { string },
	Modifiers: { { Kind: string, Value: number } },
}

local Prestige = {
	Singularity = {
		MinimumLifetimeCredits = 80000000000000,
		CoreRewardScale = 5000000000000,
		RequiredMachineLevels = {
			DysonFoundry = 20,
			RealityEngine = 10,
		},
		RequiredResearchNodes = {
			"RealityTheory",
			"SingularityPreparation",
		},
	},

	Offline = {
		BaseDurationSeconds = 2 * 60 * 60,
		BaseCreditEfficiency = 0.50,
		BaseResearchEfficiency = 0.25,
	},

	CoreNodes = {
		CoreOutputI = {
			Id = "CoreOutputI",
			DisplayName = "Core Output I",
			Branch = "Industry",
			Cost = 1,
			Prerequisites = {},
			Modifiers = {
				{ Kind = "GlobalCreditProduction", Value = 0.25 },
			},
		},

		CoreOutputII = {
			Id = "CoreOutputII",
			DisplayName = "Core Output II",
			Branch = "Industry",
			Cost = 2,
			Prerequisites = { "CoreOutputI" },
			Modifiers = {
				{ Kind = "GlobalCreditProduction", Value = 0.25 },
			},
		},

		MachineMastery = {
			Id = "MachineMastery",
			DisplayName = "Machine Mastery",
			Branch = "Industry",
			Cost = 4,
			Prerequisites = { "CoreOutputII" },
			Modifiers = {
				{ Kind = "MilestoneBonusStrength", Value = 0.25 },
			},
		},

		GenesisIndustry = {
			Id = "GenesisIndustry",
			DisplayName = "Genesis Industry",
			Branch = "Industry",
			Cost = 8,
			Prerequisites = { "MachineMastery" },
			Modifiers = {
				{ Kind = "StartingIndustryBonus", Value = 1 },
			},
		},

		ResearchMemoryI = {
			Id = "ResearchMemoryI",
			DisplayName = "Research Memory I",
			Branch = "Knowledge",
			Cost = 1,
			Prerequisites = {},
			Modifiers = {
				{ Kind = "ResearchProduction", Value = 0.20 },
			},
		},

		ResearchMemoryII = {
			Id = "ResearchMemoryII",
			DisplayName = "Research Memory II",
			Branch = "Knowledge",
			Cost = 3,
			Prerequisites = { "ResearchMemoryI" },
			Modifiers = {
				{ Kind = "ResearchProduction", Value = 0.30 },
			},
		},

		FastTheory = {
			Id = "FastTheory",
			DisplayName = "Fast Theory",
			Branch = "Knowledge",
			Cost = 5,
			Prerequisites = { "ResearchMemoryII" },
			Modifiers = {
				{ Kind = "ResearchCostReduction", Value = 0.15 },
			},
		},

		ScientificLegacy = {
			Id = "ScientificLegacy",
			DisplayName = "Scientific Legacy",
			Branch = "Knowledge",
			Cost = 8,
			Prerequisites = { "FastTheory" },
			Modifiers = {
				{ Kind = "StartingResearch", Value = 50 },
			},
		},

		StartingAutomation = {
			Id = "StartingAutomation",
			DisplayName = "Starting Automation",
			Branch = "Automation",
			Cost = 5,
			Prerequisites = {},
			Modifiers = {
				{ Kind = "StartRecyclerAutomated", Value = 1 },
			},
		},

		AutoPurchase = {
			Id = "AutoPurchase",
			DisplayName = "Auto Purchase",
			Branch = "Automation",
			Cost = 8,
			Prerequisites = { "StartingAutomation" },
			Modifiers = {
				{ Kind = "UnlockAutoPurchase", Value = 1 },
			},
		},

		AutoUpgrade = {
			Id = "AutoUpgrade",
			DisplayName = "Auto Upgrade",
			Branch = "Automation",
			Cost = 12,
			Prerequisites = { "AutoPurchase" },
			Modifiers = {
				{ Kind = "UnlockAutoUpgrade", Value = 1 },
			},
		},

		AdvancedAutomation = {
			Id = "AdvancedAutomation",
			DisplayName = "Advanced Automation",
			Branch = "Automation",
			Cost = 20,
			Prerequisites = { "AutoUpgrade" },
			Modifiers = {
				{ Kind = "UnlockAdvancedAutomation", Value = 1 },
			},
		},

		OfflineEfficiencyI = {
			Id = "OfflineEfficiencyI",
			DisplayName = "Offline Efficiency I",
			Branch = "Offline",
			Cost = 1,
			Prerequisites = {},
			Modifiers = {
				{ Kind = "OfflineCreditEfficiency", Value = 0.15 },
			},
		},

		OfflineCapacityI = {
			Id = "OfflineCapacityI",
			DisplayName = "Offline Capacity I",
			Branch = "Offline",
			Cost = 2,
			Prerequisites = {},
			Modifiers = {
				{ Kind = "OfflineDurationSeconds", Value = 2 * 60 * 60 },
			},
		},

		OfflineEfficiencyII = {
			Id = "OfflineEfficiencyII",
			DisplayName = "Offline Efficiency II",
			Branch = "Offline",
			Cost = 4,
			Prerequisites = { "OfflineEfficiencyI" },
			Modifiers = {
				{ Kind = "OfflineCreditEfficiency", Value = 0.15 },
			},
		},

		OfflineCapacityII = {
			Id = "OfflineCapacityII",
			DisplayName = "Offline Capacity II",
			Branch = "Offline",
			Cost = 6,
			Prerequisites = { "OfflineCapacityI" },
			Modifiers = {
				{ Kind = "OfflineDurationSeconds", Value = 4 * 60 * 60 },
			},
		},
	} :: { [string]: CoreNode },
}

return table.freeze(Prestige)
