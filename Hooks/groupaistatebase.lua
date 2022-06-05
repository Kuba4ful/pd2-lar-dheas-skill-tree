local data = GroupAIStateBase.convert_hostage_to_criminal

function GroupAIStateBase:convert_hostage_to_criminal(unit, peer_unit)
	-- local player_unit = peer_unit or managers.player:player_unit()
	-- local max_minions = 1
	data(self, unit, peer_unit)
	local player_unit = peer_unit or managers.player:player_unit()
	
	-- bit pasted from original groupaistatebase to see if it works
	if not alive(player_unit) or not self._criminals[player_unit:key()] then
		return
	end

	if not alive(unit) then
		return
	end

	local u_key = unit:key()
	local u_data = self._police[u_key]

	if not u_data then
		return
	end
	
	
	local bonuses = 0
	if peer_unit then
		log('is peer')
		if peer_unit:base():has_category_upgrade("player", "denis_on_convert_bonus") then
			log('[has denis skill')
			bonuses = peer_unit:base():upgrade_value("player", "denis_on_convert_bonus") or 0
			peer_unit:base():activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, value is second
			peer_unit:base():activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2]) --duration is first, value is second
			log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		end
	else
		log('is not peer')
		if managers.player:has_category_upgrade("player", "denis_on_convert_bonus") then
			log('[has denis skill')
			bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", 0)
			managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1])
			managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
			log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		end
	end
	
	


end