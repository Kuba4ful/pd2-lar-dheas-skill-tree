--HUDTeammate _stacks_panel hud
--this hud is referenced in playerdamage.lua and it's text field "stacks_text" is updated by function PlayerDamage:survival_stack()
local init_original = HUDTeammate.init
function HUDTeammate:init(i, teammates_panel, is_player, width, ...)
    init_original(self, i, teammates_panel, is_player, width, ...)
    if not self._main_player then return end
    self:init_stacks_panel(self, i, teammates_panel, is_player, width, ...)
    --self:_truncate_name()
    
    --[[ local loc_name_panel = self._panel:child("name")
    local loc_name_panel_bg = self._panel:child("name_bg")
    local loc_name_panel_text = loc_name_panel:text()
    local max_name_panel_width = loc_name_panel:w() - 20 - (loc_kills_panel:w() or 0)
    loc_name_panel:set_vertical("center")
    loc_name_panel:set_font_size(tweak_data.hud_players.name_size)
    if not self._ai then
        loc_name_panel:set_w(self._panel:w() - loc_name_panel:x())
    end
    local _,_,w,h = loc_name_panel:text_rect()
    --while loop to make sure the name panel is not too big
    --if it is too big, decrease the font size to a minimum of 14
    --if the minimum is reached, and the text still is too big, then the text is truncated
   --[[  while (loc_name_panel:x() + w) > max_name_panel_width do
        if loc_name_panel:font_size() >= 14 then
            --decrease font size by 0.1
            loc_name_panel:set_font_size(loc_name_panel:font_size() - 0.1)
        else
            --truncate text
            loc_name_panel:set_text(loc_name_panel_text:sub(1, loc_name_panel_text:len() - 1))
        end
        loc_name_panel_text = loc_name_panel:text() -- update local variable to current text
        _,_,w,h = loc_name_panel:text_rect()
    end ]]
    --[[ if (loc_name_panel:x() + w) > max_name_panel_width and loc_name_panel:font_size() > 14.1 then
        --decrease font size to 14
        loc_name_panel:set_font_size(14.1)
        _,_,w,h = loc_name_panel:text_rect()
        loc_name_panel_text = loc_name_panel:text() -- update local variable to current text
    end
    while (loc_name_panel:x() + w) > max_name_panel_width do
        --truncate text
        loc_name_panel:set_text(loc_name_panel_text:sub(1, loc_name_panel_text:len() - 1))
        loc_name_panel_text = loc_name_panel:text() -- update local variable to current text
        _,_,w,h = loc_name_panel:text_rect()
    end
    loc_name_panel_bg:set_w(w + 20)
    loc_name_panel_bg:set_h(h + 4)
    loc_name_panel_bg:set_y(loc_name_panel:y() - 2) ]]
    --loc_name_panel_bg:set_y(loc_name_panel:y() + loc_name_panel:h() / 2 - h / 2 - 1)

    --[[ while (loc_name_panel:x() + w) > max_name_panel_width do
        if loc_name_panel:font_size() > 14.1 then
            loc_name_panel:set_font_size(loc_name_panel:font_size() - 1)
        else
            loc_name_panel:set_text(loc_name_panel_text:sub(1, loc_name_panel_text:len() - 1))
        end
        loc_name_panel_text = loc_name_panel:text()
        _,_,w,h = loc_name_panel:text_rect()
    end ]]--[[ 
    loc_name_panel_bg:set_w(loc_name_panel:w() + 20)
    loc_name_panel_bg:set_h(loc_name_panel:h() + 4)
    loc_name_panel_bg:set_x(loc_name_panel:x() - 10)
    loc_name_panel_bg:set_y(loc_name_panel:y() - 2) ]]


    --end
    --self._panel:set_size(self._panel:w() + 20, self._panel:h() + 20)
    
end
function HUDTeammate:init_stacks_panel(i, teammates_panel, is_player, width, ...)
    local loc_radial_health_panel = self._radial_health_panel
    log('init_stacks_panel called')
    --if self._kills_panel not nil then 
    
    --support for custom huds
    local loc_kills_panel = self._kills_panel or 0
    local loc_name_panel = self._panel:child("name")
    self._stacks_panel = self._panel:panel({
        name = "stacks_panel",
        halign = "right",
        w = 30,
        h = 20,
        x = loc_name_panel:x(),
        y = loc_name_panel:y(),
        layer = loc_radial_health_panel:layer() + 1
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
        alpha = 0.4,
        w = self._stacks_panel:w(),
        h = self._stacks_panel:h(),
        layer = self._stacks_panel:layer() - 1
    })
    self._stacks_text = self._stacks_panel:text({
        name = "stacks_text",
        text = "---",
        align = "center",
        vertical = "center",
        horizontal = "center",
        color = Color.green,
        font_size = self._stacks_panel:h() - 1,
        font = tweak_data.hud_players.name_font,
        layer = self._stacks_panel:layer() + 1
    })
    --[[
        name = "stacks_text",
        text = "---",
        align = "right",
        vertical = "center",
        font_size = self._stacks_panel:h(),
        font = tweak_data.hud_players.name_font,
        color = Color.green,
        layer = self._stacks_panel:layer() + 1 --]]
    --self._stacks_text:set_right(self._stacks_panel:right())
    log('panel coordinates: x' .. tostring(self._stacks_panel:x()) .. ', y' .. tostring(self._stacks_panel:y()) .. ', w' .. tostring(self._stacks_panel:w()) .. ', h' .. tostring(self._stacks_panel:h()))
    log('loc_radial_health_panel coordinates: x' .. tostring(loc_radial_health_panel:x()) .. ', y' .. tostring(loc_radial_health_panel:y()) .. ', w' .. tostring(loc_radial_health_panel:w()) .. ', h' .. tostring(loc_radial_health_panel:h()))
    self:_truncate_name()
end
--[[ local update_original = HUDTeammate.update
function HUDTeammate:update(t, dt, ...)
    update_original(self, t, dt, ...)
    --[[ if self._stacks_panel:visible() then
        self._stacks_text:set_text(tostring(self._stacks_amount))
        self._stacks_text:set_visible(self._stacks_amount > 0)
    end ]]
--end 
local _truncate_vhud_original = HUDTeammate._truncate_name
function HUDTeammate:_truncate_name()
    _truncate_vhud_original(self)
    if not self._main_player then return end
   -- if self._stacks_panel:visible() then
        local loc_kills_panel = self._panel:child("kills_panel")
        local loc_name_panel = self._panel:child("name")
        local loc_name_panel_text = loc_name_panel:text()
        local loc_name_panel_bg = self._panel:child("name_bg")
        --local max_name_panel_width = ((self._kills_panel:x() + self._kill_icon:x() - 4) or 0) - 30 - 4
        local max_name_panel_width = (self._max_name_panel_width or 0) - 30 - 4
        log('loc_kills_panel width' .. tostring((loc_kills_panel:w() or 0)))
        if not self._ai then
            loc_name_panel:set_w(self._panel:w() - loc_name_panel:x())
        end
        local _,_,w,h = loc_name_panel:text_rect()
        if (loc_name_panel:x() + w) > max_name_panel_width and loc_name_panel:font_size() > 14.1 then
            loc_name_panel:set_font_size(14.1)
            log('current font size' .. tostring(loc_name_panel:font_size()))
            loc_name_panel_text = loc_name_panel:text()
            _,_,w,h = loc_name_panel:text_rect()
            log('text_rect size' .. tostring(w) .. ', ' .. tostring(h))
        end
        while (loc_name_panel:x() + w) > max_name_panel_width do
            --truncate text
            log('name_panel length before truncation' .. tostring(loc_name_panel_text:len()))
            loc_name_panel:set_text(loc_name_panel_text:sub(1, loc_name_panel_text:len() - 1))
            loc_name_panel_text = loc_name_panel:text() -- update local variable to current text
            log('name_panel length after truncation' .. tostring(loc_name_panel_text:len()))
            _,_,w,h = loc_name_panel:text_rect()
            log('text_rect size' .. tostring(w) .. ', ' .. tostring(h))
        end
        loc_name_panel_bg:set_w(w)
        loc_name_panel_bg:set_h(h + 10)
        loc_name_panel_bg:set_x(loc_name_panel:x())
        loc_name_panel_bg:set_y(loc_name_panel:y())

        --change stacks panel coordinates depending on name panel width
        if self._stacks_panel ~= nil then
            local stacks_panel = self._stacks_panel
            local total_width = stacks_panel:w() + loc_name_panel:w() + (self._kills_panel:w() or 0) + (self._kill_icon:w() or 0)
            stacks_panel:set_x(max_name_panel_width) --doesnt adjust with kill panel fix
            --check if kills_panel_text is longer than 2 characters but shorter than 3 characters, if it is set stacks_panel x to max_name_panel_width - increased length
            if self._kills_panel ~= nil then
                if self._kills_text:text():len() > 7 then
                    stacks_panel:set_x(max_name_panel_width + (self._kills_text:text():len() * self._kills_text:font_size()) + 4)
                end
            end
            stacks_panel:set_y(loc_name_panel:y()) 
            --self._stacks_text:set_x(stacks_panel:x())
            --self._stacks_text:set_y(stacks_panel:y())
            --align stacks_text to the right of the stacks_panel
            self._stacks_text:set_right(self._stacks_panel:right() + 4)
            self._stacks_text:align(self._stacks_text:x(), self._stacks_text:y(), "center", "center")
            self._stacks_text:set_vertical("center")

            log('stacks_panel not nil')
            log('stacks_panel not nil')
            log('name panel x')
            log(tostring(loc_name_panel:x()) .. ', y' .. tostring(loc_name_panel:y()))
            log('name panel width')
            log(tostring(loc_name_panel:w()) .. ', max_width' .. tostring(max_name_panel_width))
            log('stacks_panel coordinates' .. tostring(stacks_panel:x()) .. ', ' .. tostring(stacks_panel:y()))
            log('stacks_panel text coordinates' .. tostring(self._stacks_text:x()) .. ', ' .. tostring(self._stacks_text:y()))
            log('stacks_panel text string' .. tostring(self._stacks_text:text()))
            log('stacks_panel text length' .. tostring(self._stacks_text:text():len()))
            log('stacks_panel text font size' .. tostring(self._stacks_text:font_size()))
            log('stacks_panel text width' .. tostring(self._stacks_text:w()))
            log('stacks_panel text height' .. tostring(self._stacks_text:h()))
            
        else
            log('stacks_panel is nil, calling init_stacks_panel')
            self:init_stacks_panel()
        end
    --end 
    function HUDTeammate:_update_stacks_text(stacks)
        if self._stacks_panel ~= nil then
            self._stacks_text:set_text(tostring(stacks))
            self._stacks_text:set_visible()
            log('stacks_panel update text string ' .. tostring(self._stacks_text:text()))
        end
    end
end