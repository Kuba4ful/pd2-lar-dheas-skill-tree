local data = SkillTreeTweakData.init
function SkillTreeTweakData:init(tweak_data)
	data(self, tweak_data)
	local digest = function(value)
		return Application:digest_value(value, true)
	end
	self.tier_unlocks = {
		digest(0),
		digest(1),
		digest(3),
		digest(18)
	}

	-- I like to use table.insert because self.skill_pages_order is a table and 
	-- using the insert it won't overrie the skill tree of the other modders
	-- log(tostring(type(self.skill_pages_order)))
	-- I use contain_my_skilltree for check if there is a mine skill tree (example:added by another my mod)
	local function contain_my_skilltree (tab, val)
	    for index, value in ipairs(tab) do
	        if value == val then
	            return true
	        end
	    end
	    return false
	end
	if not contain_my_skilltree(self.skill_pages_order,"predator") then
		table.insert(self.skill_pages_order,"predator")
		self.skilltree.predator = {
			name_id = "predator_skilltree",
			desc_id = "predator_skilltree_desc"
		}
	end


-- This is an empty skills
	self.skills.predator_odznaka_skill = {  --predator_empty_skill  is the name of the skill
		["name_id"] = "menu_predator_odznaka", -- Id that you will use for localization of the name check the english.txt file
		["desc_id"] = "menu_predator_odznaka_desc", -- Id that you will use for localization of the description
		["icon_xy"] = {10, 9}, -- The icon is the icon atlas {column 0 to N,row 0 to N}
		[1] = { -- Base Skill
			upgrades = {
				"player_camouflage_bonus_1",
				"camouflage_health_ratio_multiplier"
			},
			cost = self.costs.default -- the cost 
		},
		[2] = { -- Aced skill 
			upgrades = {
				"player_camouflage_bonus_2",
				"camouflage_health_ratio_multiplier2"
			},
			cost = self.costs.pro -- the cost 
		}
	}-- This is an empty skills
	
	-- self.skills.predator_empty_skill = {  --predator_empty_skill  is the name of the skill
		-- ["name_id"] = "menu_predator_odznaka", -- Id that you will use for localization of the name check the english.txt file
		-- ["desc_id"] = "menu_predator_odznaka_desc", -- Id that you will use for localization of the description
		-- ["icon_xy"] = {8, 0}, -- The icon is the icon atlas {column 0 to N,row 0 to N}
		-- [1] = { -- Base Skill
			-- upgrades = {
				
			-- },
			-- cost = self.costs.default -- the cost 
		-- },
		-- [2] = { -- Aced skill 
			-- upgrades = {
				
			-- },
			-- cost = self.costs.pro -- the cost 
		-- }
	-- }
-- -- Empty skill End

-- Skill cost infos
-- Tier 0 and 1
--       base = self.costs.default
--       aced = self.costs.pro

-- Tier 2 and 3
--       base = self.costs.hightier
--       aced = self.costs.hightierpro


-- PREDATOR SKILL
-- The values of this custom skill are inside the UpgradesTweakData.lua
	self.skills.predator_lmg_accuracy_boost = {  
		["name_id"] = "menu_lmg_accuracy_boost",
		["desc_id"] = "menu_lmg_accuracy_boost_desc",
		["icon_xy"] = {8, 5},
		[1] = {
			upgrades = {
				"lmg_spread_index_addend" --These are upgrades you can get the upgrade name 
				                          --from the UpgradesTweakData.lua let's see how the 
				                          --UpgradesTweakData file works
				                          --You can add also multiple upgrades
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"aced_lmg_spread_index_addend"
			},
			cost = self.costs.pro
		}
	}
	self.skills.predator_skora = {  
		["name_id"] = "menu_predator_skora",
		["desc_id"] = "menu_predator_skora_desc",
		["icon_xy"] = {2, 2},
		[1] = {
			upgrades = {
				"player_passive_health_multiplierr_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_bleed_out_retain",
				"player_bleed_out_retain2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.predator_convert = {  
		["name_id"] = "menu_predator_convert",
		["desc_id"] = "menu_predator_convert_desc",
		["icon_xy"] = {6, 8},
		[1] = {
			upgrades = {
				"player_passive_convert_enemies_health_multiplierr_1",
				"player_passive_convert_enemies_damage_multiplierr_1",
				"player_convert_enemies_max_minionss_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_passive_convert_enemies_health_multiplierr_2",
				"player_passive_convert_enemies_damage_multiplierr_2",
				"player_convert_enemies_max_minionss_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.predator_vincent = {  
		["name_id"] = "menu_predator_vincent",
		["desc_id"] = "menu_predator_vincent_desc",
		["icon_xy"] = {6, 1},
		[1] = {
			upgrades = {
				"player_passive_suspicion_bonuss_1",
				"player_vincent_add_dodge_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_passive_suspicion_bonuss_2",
				"player_vincent_add_dodge_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.predator_miracle = {  
		["name_id"] = "menu_predator_miracle",
		["desc_id"] = "menu_predator_miracle_desc",
		["icon_xy"] = {6, 6},
		[1] = {
			upgrades = {
				"player_regain_health_from_ammo_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_regain_health_from_ammo_1",
				"player_miracle_double_drop"
			},
			cost = self.costs.hightierpro
		}
	}
-- This is for insert our skill tre in main tree
table.insert(self.trees,{
			name_id = "predator_mentalist_tree",-- id for localization
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "predator", -- the name of your skilltree
			tiers = {
					{ -- this is a common skill tree rown with 1 skills
						"predator_odznaka_skill"
					},
					{ -- this is a common skill tree row with 2 skills
						"predator_skora",
						"predator_convert" -- This our Custom skill ! Let's see how it worksin the UpgradesTweakData file
					},
					{ -- this is a modified skill tree row with 4 skills
						"predator_vincent",
						"predator_miracle"
					}, 
					{ -- this is a modified skill tree row with 3 skills
						"predator_lmg_accuracy_boost"
					} 
				}
			})	

end