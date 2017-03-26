function HUD()

local client = LocalPlayer()

	if !client:Alive() then
		return
	end

	local healthWidth = (client:Health() / client:GetMaxHealth()) * 100

	-- hud box for health and armor
	draw.RoundedBox(0,0, ScrH() - 100, 250, 100, Color(30,30,30,150))

	-- health bar
	draw.RoundedBox(0,10,ScrH()-70,225,15,Color(0,255,0,100))
	draw.RoundedBox(0, 10, ScrH()-70, math.Clamp(healthWidth,0,100)*2.27, 15, Color(0,255,0,255))
	draw.RoundedBox(0, 10, ScrH()-70, math.Clamp(healthWidth,0,100)*2.27, 13, Color(255,0,0,255))

	-- armor bar
	draw.RoundedBox(0,10,ScrH()-30,225,15,Color(0,0,255,100))
	draw.RoundedBox(0, 10, ScrH()-30, math.Clamp(client:Armor(),0,100)*2.27, 15, Color(5,255,255,255))
	draw.RoundedBox(0, 10, ScrH()-30, math.Clamp(client:Armor(),0,100)*2.27, 13, Color(0,0,255,255))

	-- health and armor
	draw.SimpleText("Health: ".. client:Health().."%", "DermaDefaultBold", 10, ScrH() - 90, Color(5,255,255,255), 0, 0)
	draw.SimpleText("Armor: ".. client:Armor().."%", "DermaDefaultBold", 10, ScrH() - 50, Color(5,255,255,255), 0, 0)


	--hud box for ammo
	draw.RoundedBox(0,255, ScrH() - 70, 125, 70, Color(30,30,30,150))


	if(client:GetActiveWeapon():IsValid()) then
		local curWeapon = client:GetActiveWeapon():GetClass()


		-- weapon name
		if (client:GetActiveWeapon():GetPrintName() != nil) then
			draw.SimpleText(client:GetActiveWeapon():GetPrintName(),"DermaDefaultBold", 260, ScrH()-50,Color(5,255,255,255), 0, 0)
		end
		if(curWeapon !="weapon_physgun" && curWeapon !="weapon_physcannon" && curWeapon !="weapon_crowbar") then
		-- Ammo count
			if(client:GetActiveWeapon():Clip1() != -1) then
				draw.SimpleText("Ammo: "..client:GetActiveWeapon():Clip1().."/"..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()),"DermaDefaultBold", 260, ScrH()-30,Color(5,255,255,255), 0, 0)
			else
				draw.SimpleText("Ammo: "..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()),"DermaDefaultBold", 260, ScrH()-30,Color(5,255,255,255), 0, 0)
			end

			--secondary ammo count
			if(client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType()) > 0) then
				draw.SimpleText("Secondary: "..client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType()),"DermaDefaultBold", 260, ScrH()-17,Color(5,255,255,255), 0, 0)
			end
		end
	end
	-- box/code for exp and level
	local expToLevel = (client:GetNWInt("playerLvl") * 100) * 2

	draw.RoundedBox(0,0,ScrH()-143,250,40, Color(30,30,30,150))
	draw.SimpleText("Level "..client:GetNWInt("playerLvl"),"DermaDefaultBold",10,ScrH()-140,Color(5,255,255,255), 0, 0)
	draw.SimpleText("EXP:  "..client:GetNWInt("playerExp").."/"..expToLevel,"DermaDefaultBold",10,ScrH()-125,Color(5,255,255,255), 0, 0)

	--box/code for money
	draw.RoundedBox(0,255, ScrH() - 98, 125, 25, Color(30,30,30,150))
	draw.SimpleText("$ "..client:GetNWInt("playerMoney"),"DermaDefaultBold",260,ScrH()-95,Color(5,255,255,255), 0, 0)

	draw.RoundedBox(0, 385, ScrH() - 5, ScrW() - 390, 5, Color(30, 30, 30, 230))
	draw.RoundedBox(0, 385, ScrH() - 5, (client:GetNWInt("playerExp") / expToLevel) * (ScrW() - 390), 5, Color(50, 200, 10, 255))
end
hook.Add("HUDPaint","TestHud",HUD)

function HideHud(name)

	for k, v in pairs({"CHudHealth","CHudBattery","CHudAmmo","CHudSecondaryAmmo"}) do

		if name == v then

		return false
		end
	end
end
hook.Add("HUDShouldDraw","HidedefaultHud", HideHud)
