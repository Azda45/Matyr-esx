function AddTextEntry(k, v)
   Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), k, v)
end

local fivem_title = "~p~Matyr ~s~Network ~o~FiveM"
local map_category = "Map"

-- local game_category = "Take the plane"
-- local disconnect_submenu = "Go back to the list of servers"
-- local closegame_submenu = "Exit FiveM and return to desktop"

-- local info_category = "Logs"
-- local statistics_category = "Statistics"
-- local settings_category = "Settings"
-- local gallery_category = "Gallery"
local rockstar_editor_category = "∑ Editor"

local fivem_key_config_submenu = "~o~FiveM Keys"

Citizen.CreateThread(function()
   AddTextEntry('FE_THDR_GTAO', fivem_title)
   AddTextEntry('PM_SCR_MAP', map_category)
   -- AddTextEntry('PM_SCR_GAM', game_category)
   -- AddTextEntry('PM_PANE_LEAVE', disconnect_submenu)
   -- AddTextEntry('PM_PANE_QUIT', closegame_submenu)
   -- AddTextEntry('PM_SCR_INF', info_category)
   -- AddTextEntry('PM_SCR_STA', statistics_category)
   -- AddTextEntry('PM_SCR_SET', settings_category)
   -- AddTextEntry('PM_SCR_GAL', gallery_category)
   AddTextEntry('PM_SCR_RPL', rockstar_editor_category)
   AddTextEntry('PM_PANE_CFX', fivem_key_config_submenu)
end)
