local initself = PlayerManager.init
function PlayerManager:init(...)
	initself(self, ...)
	self._survival_stacks = 0 --reset stacks for adaptation skill
	self._dodge_stacks = 0
	self._speed_stacks = 0 
	self._regen_stacks = 0 --the "crit reduction"
	self._reduction_stacks = 0
	self._flashbang_stacks = 0
	self._can_insta_flash = 0
end

--this part here is redundant, will get removed
function PlayerManager:set_survival_stacks(stacks)
	self._survival_stacks = stacks
end

function PlayerManager:get_survival_stacks()
	return self._survival_stacks
end



local data = PlayerManager.skill_dodge_chance

function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk, ...)
	--data(self)
	local chance = data(self, ...)
	local detection_risk_add_dodge_chance = managers.player:upgrade_value("player", "detection_risk_add_dodge_chance")
	local vincent_detection_dodge = managers.player:upgrade_value("player", "vincent_detection_dodge")
	
	if self:get_value_from_risk_upgrade(detection_risk_add_dodge_chance, detection_risk) == 0.1 then
		chance = chance + self:upgrade_value("player", "vincent_add_dodge", 0)
	end
	
	if self:has_category_upgrade("player", "vincent_detection_dodge") then
		chance = chance + self:get_value_from_risk_upgrade(vincent_detection_dodge, detection_risk)
	end
	
	if not alive(self:player_unit()) then
		return chance
	else -- {
	
	if self:has_category_upgrade("player", "badge_dodge") and self:player_unit():character_damage():health_ratio() > 0.6 then
		chance = chance + self:upgrade_value("player", "badge_dodge", 0)
	end
	
	if self:has_category_upgrade("player", "survival_add_dodge") then
	
		chance = chance - self:upgrade_value("player", "survival_lose_dodge")  
		local stack_bonus = self:upgrade_value("player", "survival_add_dodge")
		
		chance = chance + (stack_bonus[1] * self._dodge_stacks)
		
	end
	
	return chance
	
	end -- }
	
end

local data2 = PlayerManager.check_skills
function PlayerManager:check_skills()
	data2(self)
	
	if self:has_category_upgrade("player", "miracle_double_drop") then
		self._target_kills = self:upgrade_value("player", "miracle_double_drop", 0) --every which kill

		self._message_system:register(Message.OnEnemyKilled, "miracle_double_ammo_drop", callback(self, self, "_on_spawn_extra_ammo_event"))
	else
		self._target_kills = 0

		self._message_system:unregister(Message.OnEnemyKilled, "miracle_double_ammo_drop")
	end
end

local orig_function_speed = PlayerManager.movement_speed_multiplier
function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio, ...)

	local multiplier = orig_function_speed(self, speed_state, bonus_multiplier, upgrade_level, health_ratio, ...) - managers.player:upgrade_value("player", "survival_lose_speed", 0)
	
	if managers.player:has_category_upgrade("player", "survival_add_speed") and self._speed_stacks > 0 then
		multiplier = multiplier + (managers.player:upgrade_value("player", "survival_add_speed")[1] * self._speed_stacks)
	end
	
	return multiplier
end

local orig_function_reduction = PlayerManager.damage_reduction_skill_multiplier
function PlayerManager:damage_reduction_skill_multiplier(damage_type, ...)

	local multiplier = orig_function_reduction(self, damage_type, ...) - managers.player:upgrade_value("player", "survival_lose_reduction", 0)
	
	if managers.player:has_category_upgrade("player", "survival_add_reduction") and self._reduction_stacks > 0 then
		multiplier = multiplier + (managers.player:upgrade_value("player", "survival_add_reduction")[1] * self._reduction_stacks)
	end
	
	return multiplier
end

-- function PlayerManager:_on_flashbang_cooldown_end()
	-- log('FLASHBANG COOLDOWN END ')
-- end
--local dataDenis = PlayerManager.chk_minion_limit_reached  --incompatible with other mods 
														  --as it doesn't call the function back
														  --add in todo on github
--local local_player_minions = PlayerManager
-- function PlayerManager:chk_minion_limit_reached(peer_unit)
	-- -- local minions = 0
	-- -- if self:upgrade_value("player", "denis_max_minions", 0) == not nil then
		-- -- minions = self:upgrade_value("player", "convert_enemies_max_minions", 0) + self:upgrade_value("player", "denis_max_minions", 0)
	-- -- else 
		-- -- minions = self:upgrade_value("player", "convert_enemies_max_minions", 0)
	-- -- end
	-- -- return minions <= self._local_player_minions
	-- local minions = 0
	-- if peer_unit then
		-- log('is peer')
		-- minions = peer_unit:base():upgrade_value("player", "convert_enemies_max_minions") or 0 + peer_unit:base():upgrade_value("player", "denis_max_minions") or 0
		-- log('minions = ' .. tostring(minions))
	-- else
		-- log('is not peer')
		-- minions = self:upgrade_value("player", "convert_enemies_max_minions", 0) + self:upgrade_value("player", "denis_max_minions", 0)
		-- log('minions = ' .. tostring(minions))
	-- end
	-- return minions <= self._local_player_minions
-- end