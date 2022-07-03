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
		
		self:survival_stack()
		
		local total_damage = self:_max_armor() + self:_max_health()
		if managers.player._regen_stacks > 0 and attack_data.damage > total_damage * 0.05 then --damage bigger than 5% of health + armor 
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
			
			
		end
		
		
	end
	-- if managers.player._flashbang_stacks > 0 and not managers.player:has_active_timer("flashbang_cooldown") then
			-- --if (math.random() > 0.5 and self:get_real_health() + self:get_real_armor() < total_damage * 0.2) or self._unit:movement():tased() then
			-- if self._unit:movement():tased() then
					-- log('[FLASHBANG] THROW CONCUSSION GRENADE ')
					
					-- --code copied from better bots lmao
					-- local crim_mov = self._unit:movement()
					-- local from_pos = crim_mov:m_head_pos()
					-- if attack_data.attacker_unit then
					-- local target_mov = attack_data.attacker_unit:movement()
					-- local target_pos = target_mov:m_pos()
					
					-- local target_dir = target_pos - from_pos
					-- local reverse_target_dir = from_pos - target_pos
					-- --local look_vec = crim_mov:m_head_rot():y()
					
					-- --local mvec_spread_direction = from_pos
					-- local cc_unit = ProjectileBase.spawn("units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_third_gre_pressure", from_pos, Rotation())
					-- --local cc_unit2 = ProjectileBase.spawn("units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_third_gre_pressure", player_pos, Rotation())
					-- mvector3.normalize(target_dir)
					-- mvector3.normalize(reverse_target_dir)
					-- --mvector3.normalize(player_pos)
					-- --crim_mov:play_redirect("throw_grenade")
					-- --managers.network:session():send_to_peers("play_distance_interact_redirect", self._unit, "throw_grenade")
					-- self._unit:sound():say("g43", true, true)
					-- cc_unit:base():throw({ dir = target_dir, owner = self._unit })
					-- --local throwable = tweak_data.blackmarket.projectiles["concussion"]
					-- --if throwable then
					-- local throwable = tweak_data.blackmarket.projectiles["concussion"]
					-- local message = "throwing concussion grenade"
					-- managers.chat:_receive_message(1, managers.localization:to_upper_text("menu_system_message"), message, tweak_data.system_chat_color)
					-- --ProjectileBase.throw_projectile_npc("concussion", from_pos, target_dir, self._unit)
					-- --ProjectileBase.throw_projectile_npc("concussion", from_pos, target_dir, attack_data.attacker_unit)
					-- --ProjectileBase.throw_projectile_npc("concussion", target_pos, reverse_target_dir, attack_data.attacker_unit)
					-- --throwable.expire_t = default_t -- set back to original fuse time
					-- --throwable.repeat_expire_t = default_t2
					-- --end
					-- --cc_unit2:base():throw({ dir = player_pos, owner = self._unit })
					
					-- local cooldown = (managers.player:upgrade_value("player", "survival_add_flashbang")[1] - managers.player._flashbang_stacks)
					-- managers.player:start_timer("flashbang_cooldown", cooldown) --, managers.player:_on_flashbang_cooldown_end
					-- log('[FLASHBANG] SELF HAS COOLDOWN: ' .. tostring(managers.player:has_active_timer("flashbang_cooldown")))
					-- end
			-- end
		-- end
		-- --log('damage_received  ' .. tostring(damage_received))
		-- --log('dodge_roll  ' .. tostring(data(self, attack_data, ...).dodge_roll))
	-- --end
	
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

local damage_tase_orig = PlayerDamage.damage_tase
function PlayerDamage:damage_tase(attack_data, ...)
	damage_tase_orig(self, attack_data, ...)
	
	if managers.player._flashbang_stacks > 0 and not managers.player:has_active_timer("flashbang_cooldown") then
	
		log('[FLASHBANG] THROW CONCUSSION GRENADE ')
		if attack_data.attacker_unit then --just a nil check, probably redundant but better safe than sorry
		
			--set positions
			local crim_mov = self._unit:movement() --redundant variable
			local from_pos = crim_mov:m_pos()
			local target_pos = attack_data.attacker_unit:movement():m_pos()
			
			local target_dir = target_pos - from_pos
			local reverse_target_dir = from_pos - target_pos
			--local look_vec = crim_mov:m_head_rot():y()
			
			--cooldown depending on stacks
			local cooldown = (managers.player:upgrade_value("player", "survival_add_flashbang")[1] - managers.player._flashbang_stacks)
			managers.player:start_timer("flashbang_cooldown", cooldown)
			
			mvector3.normalize(target_dir)
			mvector3.normalize(reverse_target_dir)
			
			self._unit:sound():say("g43", true, true) --grenade voiceline
			
			--local message = "throwing concussion grenade"
			--managers.chat:_receive_message(1, managers.localization:to_upper_text("menu_system_message"), message, tweak_data.system_chat_color)
			-- ProjectileBase.throw_projectile_npc("concussion", from_pos, target_dir, self._unit)
			-- ProjectileBase.throw_projectile_npc("concussion", target_pos, reverse_target_dir, self._unit)
			if Net:IsHost() or Net:IsMultiplayer() == nil then
				ProjectileBase.throw_projectile_npc("concussion", from_pos, target_dir, self._unit)
				ProjectileBase.throw_projectile_npc("concussion", target_pos, reverse_target_dir, self._unit)
			else
				--local data = { from_pos, target_dir, target_pos, reverse_target_dir }
				local sent_data = { from_pos:unpack(), target_dir:unpack(), target_pos:unpack(), reverse_target_dir:unpack() }
				Net:SendToPeer( 1, "ThrowConcussionGrenadeHost", json.encode(sent_data) )
			end
			
		end
	end
end

-- local orig_on_cloaker_down = PlayerDamage.on_incapacitated
-- function PlayerDamage:on_incapacitated(...)
	-- -- self:on_downed()

	-- -- self._incapacitated = true
	-- if managers.player:has_category_upgrade("player", "survival_
	-- orig_on_cloaker_down(self, ...)
-- end

local orig_on_downed = PlayerDamage.on_downed --no cloaker check?
function PlayerDamage:on_downed(...)
	orig_on_downed(self, ...)
	local pm = managers.player
	if pm._survival_cloaker_keep_stacks == 1 then
		pm._survival_cloaker_keep_stacks = 0
	else
	
		pm._survival_stacks = 1 --1 to avoid bug that gives +1 stack to everything
		pm._dodge_stacks = 0
		pm._speed_stacks = 0 
		pm._regen_stacks = 0 --the "crit reduction"
		pm._reduction_stacks = 0
		pm._flashbang_stacks = 0
		pm._can_insta_flash = 0
	
	end
end


local survival_stack_id = "survival_stack"
local concussion_throw_id = "ThrowConcussionGrenadeHost"
Hooks:Add("NetworkReceivedData", "NetworkReceivedData_survival_stack", function(sender, id, data)

    -- if id == survival_stack_id then
       -- PlayerDamage.survival_stack(self)
    -- end
	if id == concussion_throw_id then

	   local received_data = json.decode(data)
	   for i,v in ipairs(received_data) do
		   received_data[i] = Vector3(v[i], v[i+1], v[i+2])
	   end

	   ProjectileBase.throw_projectile_npc("concussion", received_data[1], received_data[2], PlayerDamage._unit)
	   log('[Concussion] Thrown by ' .. tostring(sender))
	   ProjectileBase.throw_projectile_npc("concussion", received_data[3], received_data[4], PlayerDamage._unit)
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
		--log('stacks ' .. tostring(stacks))
		
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
			log('[FLASHBANG] player flashbang stacks ' .. tostring(playerm._flashbang_stacks))
		end

		--message per 100 
		--[[ if playerm:get_survival_stacks() % 100 == 0 then
			local message = "Current Adaptation Stacks: " .. tostring(playerm:get_survival_stacks())
			managers.chat:_receive_message(1, managers.localization:to_upper_text("menu_system_message"), message, tweak_data.system_chat_color)
		end ]]
		
		--log per 100 stacks
		if playerm:get_survival_stacks() % 100 == 0 then
			log('[ADAPTATION] Player Adaptation Stacks ' .. tostring(playerm:get_survival_stacks()))
		end

		--show current stacks on hud
		
		--if HUDTeammate._stacks_panel is not visible
		--stacks_hud should be _stacks_panel from HUDTeammate:_init_stacks()
		local stacks_hud = managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:panel():child("stacks_panel")
		--local stacks_hud = HUDTeammate:_get_stacks_panel()
		if stacks_hud == nil then
			log('stack_hud is nil')
		else
		if stacks_hud:visible() == false then
			local is_visible = stacks > 0
			stacks_hud:set_visible(is_visible)
		end

		--update stacks text
		stacks_hud:child("stacks_text"):set_text(tostring(stacks))
		end
		--if HUDTeammate._stacks_panel:visible() == false then

		--	local is_visible = playerm:get_survival_stacks() > 0
		--	HUDTeammate._stacks_panel:set_visible(is_visible)
	--	end
		
		
		
		
		playerm:set_survival_stacks(stacks) -- set player stacks to local stacks
	end
end
end