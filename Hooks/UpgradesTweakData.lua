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
		self.values.player.camouflage_add_dodge = {0.02, 0.04}
		
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
		-- self.values is the value vars that contain all the category of weapon boost etc...
		-- .lmg is the category we are boosting the reload speed of and lmg so it's .lmg id is assault rifle is .assault (...I guess)
		-- .reload_speed_multiplier is the name of the boost you can check more boost in the source of the original UpgradesTweakData.lua
		-- .spread_index_addend     is the name of the boost you can check more boost in the source of the original UpgradesTweakData.lua
		
		--Later you can play with these values just remove the comment :)
		--self.values.lmg.fire_rate_multiplier = {1.20,1.4}   
		--self.values.lmg.damage_addend = {0.5}				 
		--self.values.lmg.damage_multiplier = {1.20}			 
		--self.values.lmg.extra_ammo_multiplier = {1.25,1.50}  

	self.definitions.lmg_spread_index_addend = { 
	-- lmg_spread_index_addend is name of the definition that the skilltree wil use for get the skill
	-- Check the line 64 of skilltree.lua ;)
		category = "feature", -- Info about category will be added in future
		name_id = "lmg_spread_addend", --Use an id that indify wich weapon are you editing. Info about id will be added in future
		upgrade = {
			category = "lmg", -- Like before is the weaponkind
			upgrade = "spread_index_addend", -- spread_index_addend Is where we apply our value in this case on the accuracy
			value = 1 -- Value is with value you will take in this case the first "2"
		}
	}
	-- Now you should be abbl
	self.definitions.aced_lmg_spread_index_addend = {
		category = "feature",
		name_id = "lmg_spread_addend",
		upgrade = {
			category = "lmg", -- Like before is the weaponkind
			upgrade = "spread_index_addend",-- spread_index_addend Is where we apply our value in this case on the accuracy
			value = 2 -- Value is with value you will take in this case the second "4"
		}
	}
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
	--[[ delete me --
	self.definitions.lmg_reload_speed = {
		category = "feature",
		name_id = "lmg_reload_speed",
		upgrade = {
			category = "lmg",
			upgrade = "reload_speed_multiplier",
			value = 1
		}
	}
	self.definitions.aced_lmg_reload_speed = {
		category = "feature",
		name_id = "aced_lmg_reload_speed",
		upgrade = {
			category = "lmg",
			upgrade = "reload_speed_multiplier",
			value = 2
		}
	}

	-- delete me :P ]]

end