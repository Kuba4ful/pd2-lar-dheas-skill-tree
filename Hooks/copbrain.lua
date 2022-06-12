if RequiredScript == "lib/units/enemies/cop/copbrain" then
local data = CopBrain.convert_to_criminal

function CopBrain:convert_to_criminal(mastermind_criminal, ...)

	log('copbrain converted')
	local mastermind_criminal_base = 0
	if alive(mastermind_criminal) then
		mastermind_criminal_base = mastermind_criminal:base()
	else
		mastermind_criminal_base = managers.player
	end
	
	local health_mult = (mastermind_criminal_base:upgrade_value("player", "denis_convert_health_multiplier", 1) or 1)
	
	if health_mult ~= 1 then
		log('copbrain converted' .. tostring(health_mult))
		self._logic_data.is_converted = true
		self._logic_data.group = nil
		local mover_col_body = self._unit:body("mover_blocker")

		mover_col_body:set_enabled(false)

		local attention_preset = PlayerMovement._create_attention_setting_from_descriptor(self, tweak_data.attention.settings.team_enemy_cbt, "team_enemy_cbt")

		self._attention_handler:override_attention("enemy_team_cbt", attention_preset)
		
		
		--modified code is here
		local damage_mult = (mastermind_criminal_base:upgrade_value("player", "denis_convert_damage_multiplier", 1) or 1)
		log('copbrain damage before others' .. tostring(damage_mult))

		damage_mult = damage_mult * (mastermind_criminal_base:upgrade_value("player", "convert_enemies_damage_multiplier", 1) or 1)
		damage_mult = damage_mult * (mastermind_criminal_base:upgrade_value("player", "passive_convert_enemies_damage_multiplier", 1) or 1)
		log('copbrain damage after others' .. tostring(damage_mult))
		
		if (mastermind_criminal_base:upgrade_value("player", "passive_convert_enemies_health_multiplier", 1) or 1) == 0.01 then
			health_mult = health_mult - 0.01
		elseif (mastermind_criminal_base:upgrade_value("player", "passive_convert_enemies_health_multiplier", 1) or 1) == 0.55 then
			health_mult = health_mult * 0.9
		end

		self._unit:character_damage():convert_to_criminal(health_mult)
		--end of modified code
		

		self._logic_data.attention_obj = nil

		CopLogicBase._destroy_all_detected_attention_object_data(self._logic_data)

		self._SO_access = managers.navigation:convert_access_flag(tweak_data.character.russian.access)
		self._logic_data.SO_access = self._SO_access
		self._logic_data.SO_access_str = tweak_data.character.russian.access
		self._slotmask_enemies = managers.slot:get_mask("enemies")
		self._logic_data.enemy_slotmask = self._slotmask_enemies
		local equipped_w_selection = self._unit:inventory():equipped_selection()

		if equipped_w_selection then
			self._unit:inventory():remove_selection(equipped_w_selection, true)
		end

		local weap_name = self._unit:base():default_weapon_name()

		TeamAIInventory.add_unit_by_name(self._unit:inventory(), weap_name, true)

		local weapon_unit = self._unit:inventory():equipped_unit()

		weapon_unit:base():add_damage_multiplier(damage_mult)
		self:set_objective(nil)
		self:set_logic("idle", nil)

		self._logic_data.objective_complete_clbk = callback(managers.groupai:state(), managers.groupai:state(), "on_criminal_objective_complete")
		self._logic_data.objective_failed_clbk = callback(managers.groupai:state(), managers.groupai:state(), "on_criminal_objective_failed")

		managers.groupai:state():on_criminal_jobless(self._unit)
		self._unit:base():set_slot(self._unit, 16)
		self._unit:movement():set_stance("hos")

		local action_data = {
			clamp_to_graph = true,
			type = "act",
			body_part = 1,
			variant = "attached_collar_enter",
			blocks = {
				heavy_hurt = -1,
				hurt = -1,
				action = -1,
				light_hurt = -1,
				walk = -1
			}
		}

		self._unit:brain():action_request(action_data)
		self._unit:sound():say("cn1", true, nil)
		managers.network:session():send_to_peers_synched("sync_unit_converted", self._unit)
	
	else
		log('copbrain default')
		data(self, mastermind_criminal, ...)
	end
	
end
end