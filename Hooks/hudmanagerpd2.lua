--HUDTeammate _stacks_panel hud
--this hud is referenced in playerdamage.lua and it's text field "stacks_text" is updated by function PlayerDamage:survival_stack()
local init_original = HUDTeammate.init
function HUDTeammate:init(i, teammates_panel, is_player, width, ...)
    init_original(self, i, teammates_panel, is_player, width, ...)
    local loc_radial_health_panel = self._radial_health_panel
    --if self._kills_panel not nil then --support for vhudplus
    local loc_kills_panel = self._kills_panel or 0
    --end
    --self._panel:set_size(self._panel:w() + 20, self._panel:h() + 20)
    self._stacks_panel = self._panel:panel({
        name = "stacks_panel",
        --halign = "right",
        w = 20,
        h = 20,
        x = loc_kills_panel:x() + loc_kills_panel:w() + 10,
        y = loc_kills_panel:y()
        -- x,y start at the bottom right of the radial_health_panel and increase upwards
        --x = loc_radial_health_panel:x() - loc_radial_health_panel:w() - 40,
		-- y = loc_radial_health_panel:y() + loc_radial_health_panel:height() - 20 --shift by health panel height - this panel height
		--y = loc_radial_health_panel:y() + loc_radial_health_panel:height() - 20
        --layer = loc_radial_health_panel:layer() + 1
    })
    --self._stacks_panel:set_bottom(self._panel:bottom())
    --self._stacks_panel:set_right(self._panel:right())
    self._stacks_panel:set_visible(false)
    self._stacks_background = self._stacks_panel:rect({
        name = "stacks_background",
        color = Color.black,
        alpha = 0.5,
        w = self._stacks_panel:w(),
        h = self._stacks_panel:h()
    })
    self._stacks_text = self._stacks_panel:text({
        name = "stacks_text",
        text = "---",
        align = "center",
        vertical = "center",
        font_size = self._stacks_panel:h(),
        font = tweak_data.hud_players.name_font,
        color = Color.green,
        layer = 1
    })
    self._stacks_text:set_right(self._stacks_panel:right())
    log('panel coordinates: x' .. tostring(self._stacks_panel:x()) .. ', y' .. tostring(self._stacks_panel:y()) .. ', w' .. tostring(self._stacks_panel:w()) .. ', h' .. tostring(self._stacks_panel:h()))
    log('loc_radial_health_panel coordinates: x' .. tostring(loc_radial_health_panel:x()) .. ', y' .. tostring(loc_radial_health_panel:y()) .. ', w' .. tostring(loc_radial_health_panel:w()) .. ', h' .. tostring(loc_radial_health_panel:h()))
end
--[[ local update_original = HUDTeammate.update
function HUDTeammate:update(t, dt, ...)
    update_original(self, t, dt, ...)
    --[[ if self._stacks_panel:visible() then
        self._stacks_text:set_text(tostring(self._stacks_amount))
        self._stacks_text:set_visible(self._stacks_amount > 0)
    end ]]
--end 
