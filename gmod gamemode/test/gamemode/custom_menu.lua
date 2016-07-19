local Menu

net.Receive("FMenu", function()
if(Menu == nil) then
-- creates a menu and shows it


      Menu = vgui.Create("DFrame")
      Menu:SetSize(750,500)
      Menu:SetPos(ScrW()/2 - 325, ScrH()/2 - 250)  -- divide screen width and height by 2 to get center point and then subtract by half for x and y to center menu
      Menu:SetTitle("Gamemode Menu")
      Menu:SetDraggable(false)
      Menu:ShowCloseButton(false)
      Menu:SetDeleteOnClose(false)

      Menu.Paint = function()
        surface.SetDrawColor(50,50,50,255)
        surface.DrawRect(0,0,Menu:GetWide(),Menu:GetTall())

        surface.SetDrawColor(30,30,30,255)
        surface.DrawRect(0,24,Menu:GetWide(),1)
      end
    end

    addButtons(menu)


    if(net.ReadBit() == 0) then
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
  playerButton:SetSize(100,50)
  playerButton:SetPos(365,200)
  playerButton.Paint = function()
    --color of entire button
    surface.SetDrawColor(60,60,60,255)
    surface.DrawRect(0,0,playerButton:GetWide(),playerButton:GetTall())

    --draw bottom and right borders
    surface.SetDrawColor(30,30,30,255)
    surface.DrawRect(0,49,playerButton:GetWide(),1)
    surface.DrawRect(99,0, 1,playerButton:GetTall())

    --draw text
    draw.DrawText("Click me!","DermaDefaultBold",playerButton:GetWide()/2,17, Color(255,255,255,255), 1)


end

local storeButton = vgui.Create("DButton")
storeButton:SetParent(Menu)
storeButton:SetText("")
storeButton:SetSize(100,50)
storeButton:SetPos(365,250)
storeButton.Paint = function()
  --color of entire button
  surface.SetDrawColor(60,60,60,255)
  surface.DrawRect(0,0,playerButton:GetWide(),playerButton:GetTall())

  --draw bottom and right borders
  surface.SetDrawColor(30,30,30,255)
  surface.DrawRect(0,49,playerButton:GetWide(),1)
  surface.DrawRect(99,0, 1,playerButton:GetTall())

  --draw text
  draw.DrawText("Store","DermaDefaultBold",playerButton:GetWide()/2,17, Color(255,255,255,255), 1)

  end
end
