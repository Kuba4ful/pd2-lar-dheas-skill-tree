local original_data = PlayerMovement._apply_attention_setting_modifications

function PlayerMovement:_apply_attention_setting_modifications(setting, ...)
	original_data(self, setting, ...)
	setting.detection = self._unit:base():detection_settings()

	if managers.player:has_category_upgrade("player", "camouflage_badge") then
		setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	end
	
	-- if managers.player >= PlayerManager.max_health() / 2 then
		-- setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	-- end
	local player_manager_unit = managers.player:player_unit()
		--log('health ratio' .. tostring(player_manager_unit:character_damage():health_ratio()))
		--log('badge threshold' .. tostring(managers.player:upgrade_value("player", "badge_threshold", 1)))
	if player_manager_unit:character_damage():health_ratio() > 0.6 then
		setting.weight_mul = (setting.weight_mul or 1) * managers.player:upgrade_value("player", "camouflage_badge", 1)
	end
end

local on_cloaker = PlayerMovement.on_SPOOCed
function PlayerMovement:on_SPOOCed(enemy_unit, ...)
	if managers.player:has_category_upgrade("player", "survival_cloaker_keep_stacks") then
		managers.player._survival_cloaker_keep_stacks = 1
		local stacks = managers.player:get_survival_stacks()
		log('stacks after downed cloaker ' .. tostring(stacks))
		log('cloaker_keep_stacks ' .. tostring(managers.player._survival_cloaker_keep_stacks))
	end
	on_cloaker(self, enemy_unit, ...)
end