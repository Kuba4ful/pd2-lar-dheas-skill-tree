if RequiredScript == "lib/units/beings/player/playerdamage" then
local Net = _G.LuaNetworking
local data = PlayerDamage.damage_bullet
local prev_attack_data = 0

-- Hooks:PostHook( PlayerDamage, "damage_bullet", "damage_bullet_survival_stack", function(self, attack_data)
function PlayerDamage:damage_bullet(attack_data, ...)
	data(self, attack_data, ...)
	-- --local damage_received = data(self, attack_data, ...)
	-- --local my_dodge_roll = data(self, attack_data, ...).dodge_roll
	if prev_attack_data ~= attack_data.damage and attack_data.damage > 0 then -- dodgy fix for repeated execution
		prev_attack_data = attack_data.damage
	-- --if damage_received == 0 and my_dodge_roll ~= nil then
		log('attack_data.damage  ' .. tostring(attack_data.damage))
		self:survival_stack()
		-- --log('damage_received  ' .. tostring(damage_received))
		-- --log('dodge_roll  ' .. tostring(data(self, attack_data, ...).dodge_roll))
	-- --end
	end
	
	
	-- --if Net:IsHost() or Net:IsMultiplayer() == nil then
		-- --Net:SendToPeers( "survival_stack", "true" )
			-- --log('_on_damage_event')
	-- -- log('attack_data.damage  ' .. tostring(attack_data.damage))
	-- -- log('health_subtracted  ' .. tostring(health_subtracted))
		-- -- 
	-- --end

	-- --return damage_received
 end

local survival_stack_id = "survival_stack"
Hooks:Add("NetworkReceivedData", "NetworkReceivedData_survival_stack", function(sender, id, data)

    if id == survival_stack_id then
       PlayerDamage.survival_stack(self)
    end

end)

--local function for every player
function PlayerDamage:survival_stack()
			log('function survival_stack called')

	if managers.player:has_category_upgrade("player", "survival_add_dodge") then --check for any ability
	
		local playerm = managers.player
		local stacks = playerm:get_survival_stacks()
		
		--add stack
		stacks = stacks + 1
		log('stacks ' .. tostring(stacks))
		
		--bonus stack for broken armor
		-- local armor_broken = self:_max_armor() > 0 and self:get_real_armor() <= 0

		-- if armor_broken and self._has_damage_speed then
			-- stacks = stacks + 1
			-- log('bonus stack ' .. tostring(stacks))
		-- end
		
		local dodge_bonus = playerm:upgrade_value("player", "survival_add_dodge", {0,0,0}) 
		--bonus per step, max bonus, stacks per step
		
		if playerm:get_survival_stacks() % dodge_bonus[3] == 0 and playerm._dodge_stacks < dodge_bonus[2] then
			-- --local stacks = self:get_dodge_stacks() + 1
			-- --self:set_dodge_stacks(stacks)
			playerm._dodge_stacks = playerm._dodge_stacks + 1
			log('[DODGE] player dodge stacks ' .. tostring(playerm._dodge_stacks))
		end
		--if stacks % dodge_bonus[3] == 0 then
			
		--end
		
		-- local bonuses = managers.player:upgrade_value("player", "denis_on_convert_bonus", {0,0,0})
		-- log('bonuses' .. tostring(bonuses[1]) .. tostring(bonuses[2]))
		-- managers.player:activate_temporary_property("revived_damage_reduction", bonuses[3], bonuses[1]) 	--duration is first, value is second
		-- managers.player:activate_temporary_property("team_damage_speed_multiplier_received", bonuses[3], bonuses[2])
		playerm:set_survival_stacks(stacks) -- set stacks to stacks
	end
end
end