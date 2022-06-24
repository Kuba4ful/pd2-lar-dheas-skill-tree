--ConcussionGrenade._PLAYER_FLASH_RANGE = 500
function ConcussionGrenade:update(unit, t, dt, ...)

	if self._thrower_unit == managers.player:player_unit() and self._thrower_unit:movement():current_state_name() == "tased" then
	
		self._timer = 0
	end

	ConcussionGrenade.super.update(self, unit, t, dt)
end