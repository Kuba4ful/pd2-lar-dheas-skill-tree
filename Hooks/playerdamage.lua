if RequiredScript == "lib/units/beings/player/playerdamage" then
local Net = _G.LuaNetworking
local data = PlayerDamage.damage_bullet
local prev_attack_data = 0

-- Hooks:PostHook( PlayerDamage, "damage_bullet", "damage_bullet_survival_stack", function(self, attack_data)
function PlayerDamage:damage_bullet(attack_data, ...)
		
	
	data(self, attack_data, ...)
	if managers.player:has_category_upgrade("player", "survival_add_dodge") then
	log('attack_data.damage ' .. tostring(attack_data.damage))
	-- --local damage_received = data(self, attack_data, ...)
	-- --local my_dodge_roll = data(self, attack_data, ...).dodge_roll
	if prev_attack_data ~= attack_data.damage and attack_data.damage > 0 then -- dodgy fix for repeated execution
		prev_attack_data = attack_data.damage
	-- --if damage_received == 0 and my_dodge_roll ~= nil then
		--log('attack_data.damage  ' .. tostring(attack_data.damage))
		
		self:survival_stack() -- commented for testing
		
		local total_damage = self:_max_armor() + self:_max_health()
		if managers.player._regen_stacks > 0 and attack_data.damage > total_damage * 0.05 then --damage bigger than 2% of health + armor 
			log('CRITICAL DAMGE ' .. tostring(attack_data.damage))
			log('player total_damage ' .. tostring(total_damage))
			local restore_damage_percent = managers.player:upgrade_value("player", "survival_add_regen")[1] * managers.player._regen_stacks
			local to_restore = attack_data.damage * restore_damage_percent * 0.1
			if self:_max_armor() > self:_max_health() * 0.9 then 
				self:restore_armor(to_restore)
				log('restored armor ' .. tostring(to_restore) .. '/' .. tostring(self:_max_armor()))
			else
				self:restore_health(to_restore, true)
				log('restored health ' .. tostring(to_restore) .. '/' .. tostring(self:_max_health()))
			end
			if managers.player._flashbang_stacks > 0 and not managers.player:has_active_timer("flashbang_cooldown") then
			if math.random() > 0.5 then
				if self:get_real_health() + self:get_real_armor() < total_damage * 0.2 or self._unit:movement():tased() then
					log('[FLASHBANG] THROW CONCUSSION GRENADE ')
					
					--code copied from better bots lmao
					local crim_mov = self._unit:movement()
					local from_pos = crim_mov:m_head_pos()
					--local look_vec = crim_mov:m_head_rot():y()
					
					--local mvec_spread_direction = from_pos
					local cc_unit = ProjectileBase.spawn("units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_third_gre_pressure", from_pos, Rotation())
					--mvector3.normalize(mvec_spread_direction)
					crim_mov:play_redirect("throw_grenade")
					managers.network:session():send_to_peers("play_distance_interact_redirect", self._unit, "throw_grenade")
					self._unit:sound():say("g43", true, true)
					cc_unit:base():throw({ dir = from_pos, owner = self._unit })
					
					local cooldown = (managers.player:upgrade_value("player", "survival_add_flashbang")[1] - managers.player._flashbang_stacks)
					managers.player:start_timer("flashbang_cooldown", cooldown) --, managers.player:_on_flashbang_cooldown_end
				end
			end
			end
			
		end
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
		--[1] bonus [2] for every nth stack [3] max stacks ([2] * [3])
		
		if playerm:get_survival_stacks() % dodge_bonus[2] == 0 and playerm._dodge_stacks < dodge_bonus[3] then
			playerm._dodge_stacks = playerm._dodge_stacks + 1
			log('[DODGE] player dodge stacks ' .. tostring(playerm._dodge_stacks))
		end
		
		local speed_bonus = playerm:upgrade_value("player", "survival_add_speed", {0,0,0}) 
		--[1] bonus [2] for every nth stack [3] max stacks ([2] * [3])
		
		if playerm:get_survival_stacks() % speed_bonus[2] == 0 and playerm._speed_stacks < speed_bonus[3] then
			playerm._speed_stacks = playerm._speed_stacks + 1
			--PlayerStandard:_get_max_walk_speed()
			log('[SPEED] player speed stacks ' .. tostring(playerm._speed_stacks))
		end
		
		local regen_bonus = playerm:upgrade_value("player", "survival_add_regen", {0,0,0}) 
		--[1] bonus [2] for every nth stack [3] max stacks ([2] * [3])
		
		if playerm:get_survival_stacks() % regen_bonus[2] == 0 and playerm._regen_stacks < regen_bonus[3] then
			playerm._regen_stacks = playerm._regen_stacks + 1
			log('[REGEN] player regen stacks ' .. tostring(playerm._regen_stacks))
		end
		
		local reduction_bonus = playerm:upgrade_value("player", "survival_add_reduction", {0,0,0}) 
		if playerm:get_survival_stacks() % reduction_bonus[2] == 0 and playerm._reduction_stacks < reduction_bonus[3] then
			playerm._reduction_stacks = playerm._reduction_stacks + 1
			log('[REDUCTION] player reduction stacks ' .. tostring(playerm._reduction_stacks))
		end
		
		local flashbang_bonus = playerm:upgrade_value("player", "survival_add_flashbang", {0,0,0})
		if playerm:get_survival_stacks() % flashbang_bonus[2] == 0 and playerm._flashbang_stacks < flashbang_bonus[3] then
			playerm._flashbang_stacks = playerm._flashbang_stacks + 1
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