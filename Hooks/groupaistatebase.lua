local data = GroupAIStateBase.convert_hostage_to_criminal

function GroupAIStateBase:convert_hostage_to_criminal(unit, peer_unit)
	-- local player_unit = peer_unit or managers.player:player_unit()
	-- local max_minions = 1
	data(self, unit, peer_unit)
	local player_unit = peer_unit or managers.player:player_unit()
	
	-- local reduction = 0
	-- local speed = 0
	-- if peer_unit then
		-- reduction = peer_unit:base():upgrade_value("player", "denis_on_convert_bonus")[1] or 0
		-- speed = peer_unit:base():upgrade_value("player", "denis_on_convert_bonus")[2] or 0
	-- else
		-- reduction = managers.player:upgrade_value("player", "denis_on_convert_bonus", 0)[1]
		-- speed = managers.player:upgrade_value("player", "denis_on_convert_bonus", 0)[2]
	-- end
	-- log('[' .. tostring(reduction) .. tostring(speed))
	local bonuses = 0
	if peer_unit then
		if peer_unit:base():has_category_upgrade("player", "denis_on_convert_bonus") then
			log('[has denis')
			bonuses = peer_unit:base():upgrade_value("player", "denis_on_convert_bonus") or 0
			peer_unit:base():activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, second is value
			peer_unit:base():activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2]) --duration is first, second is value
		end
	else
		if managers.player:has_category_upgrade("player", "denis_on_convert_bonus") then
			log('[has denis')
			bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", 0)
			managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1])
			managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
		end
	end
	log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
	
	


end