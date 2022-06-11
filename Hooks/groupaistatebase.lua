local data = GroupAIStateBase.convert_hostage_to_criminal
local Net = _G.LuaNetworking

function GroupAIStateBase:convert_hostage_to_criminal(unit, peer_unit, ...)
	data(self, unit, peer_unit, ...)
	if Net:IsHost() or Net:IsMultiplayer() == nil then
		if unit:brain()._logic_data and unit:brain()._logic_data.is_converted then
		log('is converted')
			Net:SendToPeers( "denis_on_convert_bonus", "true" )
		-- local peer_id = peer_unit and managers.network:session():peer_by_unit(peer_unit):id() or managers.network:session():local_peer():id()
		-- local owner_base = peer_id and peer_id ~= managers.network:session():local_peer():id() and peer_unit:base() or managers.player
		-- log('peer_id ' .. tostring(peer_id))
		-- log('owner_base ' .. tostring(owner_base))
		-- --local minions = self:num_local_minions() or 0
		-- local bonuses = (owner_base:upgrade_value("player", "denis_on_convert_bonus", {0,0,0}) or {0,0,0})
		-- log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		-- owner_base:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, value is second
		-- owner_base:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2]) --duration is first, value is second
		-- log('activated effect for' .. tostring(owner_base))
		end
	end
	--local bonuses = 0
	-- log('gets to bonuses')
	-- if peer_unit then
		-- log('is peer')
		--if peer_unit:base():has_category_upgrade("player", "denis_on_convert_bonus") then
			-- log('[has denis skill')
		
		-- if peer_unit:base():upgrade_value("player", "denis_on_convert_bonus") ~= nil then
			-- log('[peer has denis skill')
			-- bonuses = peer_unit:base():upgrade_value("player", "denis_on_convert_bonus") or 0
			-- peer_unit:base():activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, value is second
			-- peer_unit:base():activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2]) --duration is first, value is second
			-- log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		-- end
	-- else
		-- log('is not peer')
		-- --return
		-- if managers.player:has_category_upgrade("player", "denis_on_convert_bonus") then
		-- --if managers.player:upgrade_value("player", "denis_on_convert_bonus") ~= nil then
			-- log('[not peer has denis skill')
			-- bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", 0)
			-- managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1])
			-- managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
			-- log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		-- end
	-- end
	--end
	--unit:base().is_convert = true


end

local denis_bonus_id = "denis_on_convert_bonus"
Hooks:Add("NetworkReceivedData", "NetworkReceivedData_denis_convert_bonus", function(sender, id, data)

    if id == denis_bonus_id then

        local owner_base = managers.player
		--log('owner_base ' .. tostring(owner_base))
		--local minions = self:num_local_minions() or 0
		local bonuses = owner_base:upgrade_value("player", "denis_on_convert_bonus", {0,0,0})
		log('[' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		owner_base:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, value is second
		owner_base:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2]) --duration is first, value is second
		log('activated effect for' .. tostring(owner_base))

    end

end)