--HUDTeammate _stacks_panel hud
--this hud is referenced in playerdamage.lua and it's text field "stacks_text" is updated by function PlayerDamage:survival_stack()
local init_original = HUDTeammate.init
function HUDTeammate:init(i, teammates_panel, is_player, width, ...)
    init_original(self, i, teammates_panel, is_player, width, ...)
    self._stacks_panel = self._panel:panel({
        name = "stacks_panel",
        halign = "right",
        w = self._panel:w() / 10,
        h = self._panel:h() / 10
    })
    self._stacks_panel:set_bottom(self._panel:bottom())
    self._stacks_panel:set_right(self._panel:right())
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
        text = "",
        align = "center",
        vertical = "center",
        font_size = tweak_data.hud.small_font_size,
        font = tweak_data.hud.small_font,
        color = Color.white,
        layer = 1
    })
    self._stacks_text:set_center(self._stacks_panel:center())
end
local update_original = HUDTeammate.update
function HUDTeammate:update(t, dt, ...)
    update_original(self, t, dt, ...)
    --[[ if self._stacks_panel:visible() then
        self._stacks_text:set_text(tostring(self._stacks_amount))
        self._stacks_text:set_visible(self._stacks_amount > 0)
    end ]]
end
