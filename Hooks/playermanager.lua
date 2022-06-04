local data = PlayerManager.skill_dodge_chance

function PlayerManager:skill_dodge_chance()
	--data(self)
	local chance = data(self)
	local detection_risk_add_dodge_chance = managers.player:upgrade_value("player", "detection_risk_add_dodge_chance")
	
	if self:get_value_from_risk_upgrade(detection_risk_add_dodge_chance, detection_risk) == 0.1 then
		chance = chance + self:upgrade_value("player", "vincent_add_dodge", 0)
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