include( "shared.lua" )
include("testhud.lua")
include("custom_menu.lua")
include("custom_scoreboard.lua")

function GM:ContextMenuOpen()
    return true -- press c context menu activated
end
