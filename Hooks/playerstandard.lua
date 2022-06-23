Hooks:PostHook(PlayerStandard, "init", "LoadConcussionResource", function(self)
	-- local data = tweak_data.blackmarket.projectiles["concussion"]
	-- if data then
		-- local unit_name = Idstring(not Network:is_server() and data.local_unit or data.unit)
		-- if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
			-- managers.dyn_resource:load(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE)
		-- end
	-- end	
	local unit_ids = Idstring("unit")
	local tweak_entry = tweak_data.blackmarket.projectiles["concussion"]
					tweak_entry.throw_allowed_expire_t = 0.01
					tweak_entry.expire_t = 0.01
					tweak_entry.repeat_expire_t = 0.01
					tweak_entry.impact_detonation = true
	local unit_name = Idstring(not Network:is_server() and tweak_entry.local_unit or tweak_entry.unit)
	local sprint_unit_name = tweak_entry.sprint_unit and Idstring(tweak_entry.sprint_unit)

	if not PackageManager:has(unit_ids, unit_name) then
	  managers.dyn_resource:load(unit_ids, unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE)
	end

	if sprint_unit_name and not PackageManager:has(unit_ids, sprint_unit_name) then
	  managers.dyn_resource:load(unit_ids, sprint_unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE)
	end
end)