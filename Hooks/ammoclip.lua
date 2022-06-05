local data = AmmoClip._pickup
local healed = 0
function AmmoClip:_pickup(unit)

	if data(self, unit) == true then
		local player_manager = managers.player
		local inventory = unit:inventory()
	
		self._picked_up = true
		local rand = math.random()
		if player_manager:has_category_upgrade("player", "regain_health_from_ammo") then
			local restore_value = 0
			local values = player_manager:upgrade_value("player", "regain_health_from_ammo", 0)
			
			if player_manager:has_category_upgrade("player", "miracle_double_drop") then
			
				if healed < 2 then
					log(tostring(healed))
					healed = healed + 1
					restore_value = math.random(values[1], values[2])
				elseif healed == 2 then
					log(tostring(healed))
					healed = healed - 2
					restore_value = math.random(values[1] + 1, values[2] + 2)
				else
					log('invalid operation lmao')
				end
				
			else
				restore_value = math.random(values[1], values[2])
			end
			
			log('[AmmoClip:_pickup] restored: ' .. tostring(restore_value))
			local damage_ext = unit:character_damage()

			if not damage_ext:need_revive() and not damage_ext:dead(z) and not damage_ext:is_berserker() then
				damage_ext:restore_health(restore_value, true)
				unit:sound():play("pickup_ammo_health_boost", nil, true)
			end

			if player_manager:has_category_upgrade("player", "regain_health_from_ammo") then
				managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "pickup", restore_value)
			end
		end
		return true
	end
	return false
end
