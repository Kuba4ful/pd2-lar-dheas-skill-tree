-- local data = GrenadeBase.init
-- function GrenadeBase:init(unit, ...)
	-- --GrenadeBase.super.init(self, unit)
	-- data(self, unit, ...)

	-- if self:projectile_entry() == "concussion" and self._thrower_unit == managers.player:player_unit() and managers.player:player_unit:movement():tased() then
		-- self._timer = 0.01
	-- end
-- end

-- function GrenadeBase:_setup_server_data()
	-- self._slot_mask = managers.slot:get_mask("trip_mine_targets")

	-- if self._init_timer then
		-- self._timer = self._init_timer
	-- end
-- end
ConcussionGrenade._PLAYER_FLASH_RANGE = 500
function ConcussionGrenade:update(unit, t, dt, ...)
	--self._thrower_unit == managers.player:player_unit() and 
	if self._thrower_unit == managers.player:player_unit() and self._thrower_unit:movement():current_state_name() == "tased" then -- and self._thrower_unit:base()._can_insta_flash == 1 then --self._thrower_unit:base()._tweak_table == "taser" then
		self._timer = 0

		--self:_detonate()

		log('it works lmaooooo')
	end
	--end
	-- elseif self._thrower_unit ~= managers.player:player_unit() then
		-- self._timer = nil

		-- self:_detonate()

		-- log('it works for taser lmoaooo')
		-- return
	
	-- if self._timer then
		-- self._timer = self._timer - dt

		-- if self._timer <= 0 then
			-- self._timer = nil

			-- self:_detonate()

			-- return
		-- end
	-- end
	ConcussionGrenade.super.update(self, unit, t, dt)
end