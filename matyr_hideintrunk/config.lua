Config = {
    -- Set the keybind to stop carrying a player
    leaveTrunkKeybind = "E", -- Default keybind which can players change in settings
    showPlayerInTrunk = true, -- Option to show player hiden in trunk
    allowBlackout = false, -- This function allows player screen to be blackouted when trunk is closed if trunk opens player will see again.

    -- Set to "ox" if you're using ox_target, "qb" if you're using qb-target
    -- If you're using qb-target, make sure to set Config.EnableDefaultOptions to false in the qb-target/init.lua (For some reason, it doesn't work with default options WTFFFF???)
    targetScript = "ox"
}
--[[
    EXPORTS

    exports['s1n_carryandhideintrunk']:isPedOnCarry() - returns true if player is carried and false if not

]]--
