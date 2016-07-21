local Menu

net.Receive("FMenu", function()
    if (Menu == nil) then
        Menu = vgui.Create("DFrame")
        Menu:SetSize(750, 500)
        Menu:SetPos(ScrW() / 2 - 325, ScrH() / 2 - 250)
        Menu:SetTitle("Gamemode Menu")
        Menu:SetDraggable(true)
        Menu:ShowCloseButton(false)
        Menu:SetDeleteOnClose(false)
        Menu.Paint = function()
            surface.SetDrawColor(60, 60, 60, 255)
            surface.DrawRect(0, 0, Menu:GetWide(), Menu:GetTall())

            surface.SetDrawColor(40, 40, 40, 255)
            surface.DrawRect(0, 24, Menu:GetWide(), 1)
        end
    end

    addButtons(Menu)

    if (net.ReadBit() == 0) then
        Menu:Hide()
        gui.EnableScreenClicker(false)
    else
        Menu:Show()
        gui.EnableScreenClicker(true)
    end
end)

function addButtons(Menu)
    local playerButton = vgui.Create("DButton")
    playerButton:SetParent(Menu)
    playerButton:SetText("")
    playerButton:SetSize(100, 50)
    playerButton:SetPos(0, 25)
    playerButton.Paint = function()
        -- Color of entire button
        surface.SetDrawColor(50, 50, 50, 255)
        surface.DrawRect(0, 0, playerButton:GetWide(), playerButton:GetTall())

        -- Draw Bottom and Right borders
        surface.SetDrawColor(40, 40, 40, 255)
        surface.DrawRect(0, 49, playerButton:GetWide(), 1)
        surface.DrawRect(99, 0, 1, playerButton:GetTall())

        -- Draw Text
        draw.DrawText("Player", "DermaDefaultBold", playerButton:GetWide() / 2, 17, Color(255, 255, 255, 255), 1)
    end

    playerButton.DoClick = function(playerButton)
        local playerPanel = Menu:Add("PlayerPanel")
    end

    local shopButton = vgui.Create("DButton")
    shopButton:SetParent(Menu)
    shopButton:SetText("")
    shopButton:SetSize(100, 50)
    shopButton:SetPos(0, 75)
    shopButton.Paint = function()
        -- Color of entire button
        surface.SetDrawColor(50, 50, 50, 255)
        surface.DrawRect(0, 0, playerButton:GetWide(), playerButton:GetTall())

        -- Draw Bottom and Right borders
        surface.SetDrawColor(40, 40, 40, 255)
        surface.DrawRect(0, 49, playerButton:GetWide(), 1)
        surface.DrawRect(99, 0, 1, playerButton:GetTall())

        -- Draw Text
        draw.DrawText("Shop", "DermaDefaultBold", playerButton:GetWide() / 2, 17, Color(255, 255, 255, 255), 1)
    end

    shopButton.DoClick = function(shopButton)
        local shopPanel = Menu:Add("ShopPanel")
    end
end

-- Player Panel
PANEL = {} -- Create an empty panel

function PANEL:Init() -- Initialize the panel
    self:SetSize(650, 475)
    self:SetPos(100, 25)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
end

vgui.Register("PlayerPanel", PANEL, "Panel")
-- End Player Panel

-- Shop Panel
PANEL = {} -- Create an empty panel

function PANEL:Init() -- Initialize the panel
    self:SetSize(650, 475)
    self:SetPos(100, 25)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
end

vgui.Register("ShopPanel", PANEL, "Panel")
-- End Shop Panel
