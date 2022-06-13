local original_data = PlayerMovement._apply_attention_setting_modifications

function PlayerMovement:_apply_attention_setting_modifications(setting, ...)
	original_data(self, setting, ...)
	setting.detection = self._unit:base():detection_settings()
	log('camouflage before badge' .. tostring(setting.weight_mul or 1)) --0.65

	if managers.player:has_category_upgrade("player", "camouflage_badge") then
		setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	end
	log('camouflage after badge' .. tostring(setting.weight_mul or 1)) --0.585
	
	-- if managers.player >= PlayerManager.max_health() / 2 then
		-- setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	-- end
	local player_manager_unit = managers.player:player_unit()
		--log('health ratio' .. tostring(player_manager_unit:character_damage():health_ratio()))
		--log('badge threshold' .. tostring(managers.player:upgrade_value("player", "badge_threshold", 1)))
	if player_manager_unit:character_damage():health_ratio() > 0.5 then
		setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
		log('camouflage more than 50% HP' .. tostring(setting.weight_mul or 1))
	end
end