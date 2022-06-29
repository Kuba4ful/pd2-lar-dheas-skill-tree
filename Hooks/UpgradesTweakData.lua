local data = UpgradesTweakData.init
function UpgradesTweakData:init(tweak_data)
	data(self, tweak_data)

	-- Hey welcome in the UpgradesTweakData file you can see that in this funcion "init(tweak_data)"
	-- I define the values Reload boost, firespeed increase, dmg boost
	-- LMGs Skills
		-- IMPORTANT INFO _multiplier is percentage {1.2, 1.5} equeals to +20% and +50%
		-- IMPORTANT INFO _addend is a simple addiction {2,4} equeals to +2 and +4

		self.values.lmg.reload_speed_multiplier = {1.2, 1.5}
		self.values.lmg.spread_index_addend = {2,4} 
		
		self.values.player.camouflage_badge = {0.9, 0.8}
		self.values.player.badge_threshold = {0.5}
		self.values.player.badge_dodge = {0.03, 0.06}
		
		self.values.player.bleed_out_health_multiplier = {99999}
		self.values.player.passive_health_multiplier = {1.2}
		self.values.player.passive_health_index_addend = {116}
		
		self.values.player.convert_enemies_max_minions = {2, 2}
		self.values.player.denis_max_minions = {1}
		self.values.player.denis_on_convert_bonus = {{0.5, 2.3, 6}, {0.5, 2.3, 6}} --damage reduction, movement speed, time
		self.values.player.denis_convert_health_multiplier = {0.02, 0.04}
		self.values.player.denis_convert_damage_multiplier = {3.5, 4.5}
		
		self.values.player.passive_concealment_modifier = {3, 5}
		self.values.player.vincent_add_dodge = {0.02, 0.04}
		self.values.player.vincent_detection_dodge = {
		{
			0.03, --value
			1, --step
			"below",
			11, --threshold
			0.03 --cap
		},
		{
			0.06,
			1,
			"below",
			11,
			0.06
		}
	}

		self.values.player.regain_health_from_ammo = {{1,1}, {1,1}}
		self.values.player.miracle_double_drop = {2}
		
		self.values.player.survival_lose_dodge = {0.05, 0.05}
		self.values.player.survival_add_dodge = {{0.01, 150, 10}, 
		{0.01, 150, 15}} --[1] bonus [2] for every nth stack [3] max stacks ([2] * [3])
		
		self.values.player.survival_lose_speed = {0.1, 0.1}
		self.values.player.survival_add_speed = {{0.02, 166, 15}, 
		{0.02, 166, 20}}
		
		self.values.player.survival_lose_health = {0.1, 0.1}
		self.values.player.survival_lose_armor = {0.15, 0.15}
		self.values.player.survival_add_regen = {{0.025, 200, 10}, 
		{0.025, 200, 16}}
		
		self.values.player.survival_lose_reduction = {0.04, 0.04}
		self.values.player.survival_add_reduction = {{0.005, 450, 24}, 
		{0.005, 450, 32}}
		
		self.values.player.survival_add_flashbang = {{25, 1000, 5}, 
		{20, 1000, 10}}
		
		self.values.player.survival_cloaker_keep_stacks = {1}

	
	self.definitions.player_camouflage_badge_1 = {
		name_id = "menu_player_camouflage_badge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "camouflage_badge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_badge_threshold = {
		name_id = "menu_player_badge_threshold",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "badge_threshold",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_camouflage_badge_2 = {
		name_id = "menu_player_camouflage_badge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "camouflage_badge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_badge_dodge_1 = {
		name_id = "menu_player_badge_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "badge_dodge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_badge_dodge_2 = {
		name_id = "menu_player_badge_dodge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "badge_dodge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_camouflage_health_ratio_multiplier = {
		name_id = "menu_player_camouflage_health_ratio_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "camouflage_health_ratio_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_camouflage_health_ratio_multiplier2 = {
		name_id = "menu_player_camouflage_health_ratio_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "camouflage_health_ratio_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_passive_health_multiplierr_1 = {
		name_id = "menu_player_health_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "passive_health_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_bleed_out_retain = {
		name_id = "menu_player_bleed_out_health_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "bleed_out_health_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_bleed_out_retain_2 = {
		name_id = "menu_player_bleed_out_health_index_addend",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "bleed_out_health_addend",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_max_minions = {
		name_id = "menu_player_denis_max_minions",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "denis_max_minions",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_on_convert_bonus_1 = {
		name_id = "menu_player_denis_on_convert_bonus",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "denis_on_convert_bonus",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_on_convert_bonus_2 = {
		name_id = "menu_player_denis_on_convert_bonus",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "denis_on_convert_bonus",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_convert_health_multiplier_1 = {
		name_id = "menu_player_denis_convert_health_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "denis_convert_health_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_convert_health_multiplier_2 = {
		name_id = "menu_player_denis_convert_health_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "denis_convert_health_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_convert_damage_multiplier_1 = {
		name_id = "menu_player_denis_convert_damage_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "denis_convert_damage_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_denis_convert_damage_multiplier_2 = {
		name_id = "menu_player_denis_convert_damage_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "denis_convert_damage_multiplier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_passive_suspicion_bonuss_1 = {
		name_id = "menu_player_passive_suspicion_bonus",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "passive_concealment_modifier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_passive_suspicion_bonuss_2 = {
		name_id = "menu_player_passive_suspicion_bonus",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "passive_concealment_modifier",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_vincent_add_dodge_1 = {
		name_id = "menu_player_vincent_add_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "vincent_add_dodge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_vincent_add_dodge_2 = {
		name_id = "menu_player_vincent_add_dodge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "vincent_add_dodge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_vincent_detection_dodge_1 = {
		name_id = "menu_player_vincent_detection_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "vincent_detection_dodge",
			synced = true,
			category = "player"
		}
	}
	self.definitions.player_vincent_detection_dodge_2 = {
		name_id = "menu_player_vincent_detection_dodge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "vincent_detection_dodge",
			synced = true,
			category = "player"
		}
	}

	self.definitions.player_regain_health_from_ammo_1 = {
		name_id = "menu_player_regain_health_from_ammo",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "regain_health_from_ammo",
			category = "player"
		}
	}
	self.definitions.player_regain_health_from_ammo_2 = {
		name_id = "menu_player_regain_health_from_ammo",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "regain_health_from_ammo",
			category = "player"
		}
	}
	self.definitions.player_miracle_double_drop = {
		name_id = "menu_player_miracle_double_drop",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "miracle_double_drop",
			category = "player"
		}
	}
	
	self.definitions.player_survival_lose_health_1 = {
		name_id = "menu_player_survival_lose_health",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_lose_health",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_health_2 = {
		name_id = "menu_player_survival_lose_health",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_lose_health",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_armor_1 = {
		name_id = "menu_player_survival_lose_armor",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_lose_armor",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_armor_2 = {
		name_id = "menu_player_survival_lose_armor",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_lose_armor",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_dodge_1 = {
		name_id = "menu_player_survival_lose_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_lose_dodge",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_dodge_2 = {
		name_id = "menu_player_survival_lose_dodge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_lose_dodge",
			category = "player"
		}
	}
	self.definitions.player_survival_add_dodge_1 = {
		name_id = "menu_player_survival_add_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_add_dodge",
			category = "player"
		}
	}
	self.definitions.player_survival_add_dodge_2 = {
		name_id = "menu_player_survival_add_dodge",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_add_dodge",
			category = "player"
		}
	}
	self.definitions.player_survival_add_speed_1 = {
		name_id = "menu_player_survival_add_speed",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_add_speed",
			category = "player"
		}
	}
	self.definitions.player_survival_add_speed_2 = {
		name_id = "menu_player_survival_add_speed",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_add_speed",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_reduction_1 = {
		name_id = "menu_player_survival_lose_reduction",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_lose_reduction",
			category = "player"
		}
	}
	self.definitions.player_survival_lose_reduction_2 = {
		name_id = "menu_player_survival_lose_reduction",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_lose_reduction",
			category = "player"
		}
	}
	self.definitions.player_survival_add_reduction_1 = {
		name_id = "menu_player_survival_add_reduction",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_add_reduction",
			category = "player"
		}
	}
	self.definitions.player_survival_add_reduction_2 = {
		name_id = "menu_player_survival_add_reduction",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_add_reduction",
			category = "player"
		}
	}
	
	self.definitions.player_survival_add_regen_1 = {
		name_id = "menu_player_survival_add_regen",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_add_regen",
			category = "player"
		}
	}
	self.definitions.player_survival_add_regen_2 = {
		name_id = "menu_player_survival_add_regen",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_add_regen",
			category = "player"
		}
	}
	self.definitions.player_survival_add_flashbang_1 = {
		name_id = "menu_player_survival_add_flashbang",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_add_flashbang",
			category = "player"
		}
	}
	self.definitions.player_survival_add_flashbang_2 = {
		name_id = "menu_player_survival_add_flashbang",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "survival_add_flashbang",
			category = "player"
		}
	}
	self.definitions.player_survival_cloaker_keep_stacks = {
		name_id = "menu_player_survival_cloaker_keep_stacks",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "survival_cloaker_keep_stacks",
			category = "player"
		}
	}

end