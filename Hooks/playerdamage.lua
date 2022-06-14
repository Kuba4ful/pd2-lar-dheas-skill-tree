local data = PlayerDamage._on_damage_event
local Net = _G.LuaNetworking

function PlayerDamage:_on_damage_event(...)
	data(self, ...)
	
	--if Net:IsHost() or Net:IsMultiplayer() == nil then
		--Net:SendToPeers( "survival_stack", "true" )
		PlayerDamage.survival_stack(self) --use function for host
	--end

	
end

local survival_stack_id = "survival_stack"
Hooks:Add("NetworkReceivedData", "NetworkReceivedData_survival_stack", function(sender, id, data)

    if id == survival_stack_id then
       PlayerDamage.survival_stack(self)
    end

end)

--local function for every player
function PlayerDamage:survival_stack()

	if managers.player:has_category_upgrade("player", "survival_add_dodge") then --check for any ability
	
		local playerm = managers.player
		local stacks = playerm:get_survival_stacks()
		
		--add stack
		stacks = stacks + 1
		log('stacks ' .. tostring(stacks))
		
		--bonus stack for broken armor
		local armor_broken = self:_max_armor() > 0 and self:get_real_armor() <= 0

		if armor_broken and self._has_damage_speed then
			stacks = stacks + 1
			log('bonus stack ' .. tostring(stacks))
		end
		
		
		-- local bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", {0,0,0})
		-- log('bonuses' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		-- managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) 	--duration is first, value is second
		-- managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
		playerm:set_survival_stacks(stacks) -- set stacks to stacks
	end
end