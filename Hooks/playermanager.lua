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
	
	return chance
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