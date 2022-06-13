local data = PlayerMovement._apply_attention_setting_modifications

function PlayerMovement:_apply_attention_setting_modifications(setting, ...)
	data(self, setting, ...)
	setting.detection = self._unit:base():detection_settings()
	log('camouflage before badge' .. tostring(setting.weight_mul or 1))

	if managers.player:has_category_upgrade("player", "camouflage_badge") then
		setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	end
	log('camouflage after badge' .. tostring(setting.weight_mul or 1))
	
	-- if managers.player >= PlayerManager.max_health() / 2 then
		-- setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	-- end
	local player = PlayerManager.player_unit()
	if alive(player) then
		if player:character_damage():health_ratio() > managers.player:upgrade_value("player", "badge_threshold", 1) then
			setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
		end
	end
	log('camouflage more than 50% HP' .. tostring(setting.weight_mul or 1))
end