local data = GroupAIStateBase.convert_hostage_to_criminal
local Net = _G.LuaNetworking

function GroupAIStateBase:convert_hostage_to_criminal(unit, peer_unit, ...)
	data(self, unit, peer_unit, ...)
	if Net:IsHost() or Net:IsMultiplayer() == nil then
		if unit:brain()._logic_data and unit:brain()._logic_data.is_converted then
			Net:SendToPeers( "denis_on_convert_bonus", "true" )
			GroupAIStateBase.on_convert(self) --use function for host
		end
	end


end

local denis_bonus_id = "denis_on_convert_bonus"
Hooks:Add("NetworkReceivedData", "NetworkReceivedData_denis_convert_bonus", function(sender, id, data)

    if id == denis_bonus_id then
       GroupAIStateBase.on_convert(self)
    end

end)

--local function for every player on convert
function GroupAIStateBase:on_convert()
	--local minions = self:num_local_minions() or 0
	local bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", {0,0,0})
	log('bonuses' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
	managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) --duration is first, value is second
	managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
end