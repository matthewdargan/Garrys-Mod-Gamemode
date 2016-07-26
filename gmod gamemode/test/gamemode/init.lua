AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("testhud.lua")
AddCSLuaFile("custom_menu.lua")
AddCSLuaFile("custom_scoreboard.lua")

include( "shared.lua" )
include("concommands.lua")

-- checks to see if f4 menu is opened or closed
local open = false

--[[ function GM:PlayerSpawn(ply)

	ply:SetGravity(.80)
	ply:SetMaxHealth(100)
	ply:SetWalkSpeed(200)
	ply:SetRunSpeed(400)
	ply:SetArmor(50)

	ply:Give("weapon_physcannon")
	ply:Give("weapon_physgun")
	ply:Give("weapon_pistol")
	ply:Give("weapon_smg1")
	ply:Give("weapon_ar2")

	ply:SetAmmo(200,"weapon_ar2")
	ply:SetAmmo(2,"AR2AltFire")

	ply:SetupHands()
end --]]

function GM:PlayerInitialSpawn(ply)
	if (ply:GetPData("playerLvl") == nil) then
		ply:SetNWInt("playerLvl", 1)
	else
		ply:SetNWInt("playerLvl", tonumber(ply:GetPData("playerLvl")))
	end

	if (ply:GetPData("playerExp") == nil) then
		ply:SetNWInt("playerExp", 0)
	else
		ply:SetNWInt("playerExp", tonumber(ply:GetPData("playerExp")))
	end

	if (ply:GetPData("playerMoney") == nil) then
		ply:SetNWInt("playerMoney", 0)
	else
		ply:SetNWInt("playerMoney", tonumber(ply:GetPData("playerMoney")))
	end

	if (ply:GetPData("playerWeapon") != nil) then
		ply:SetNWString("playerWeapon", ply:GetPData("playerWeapon"))
	end
end

function GM:OnNPCKilled(npc, attacker, inflictor)

	-- add money
	-- add exp and check for level up

	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 50)

	attacker:SetNWInt("playerExp",attacker:GetNWInt("playerExp") + 10)

	checkForLevel(attacker)
end

function GM:PlayerDeath(victim, inflictor, attacker)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 50)

	attacker:SetNWInt("playerExp",attacker:GetNWInt("playerExp") + 10)

	attacker:SetFrags(attacker:Frags() + 1)

	checkForLevel(attacker)
end

-- Default Player Loadout
function GM:PlayerLoadout(ply)
	ply:Give("weapon_pistol")
	ply:Give("weapon_physgun")
	ply:Give("weapon_physcannon")

	if (ply:GetNWString("playerWeapon") != nil) then
		ply:Give(ply:GetNWString("playerWeapon"))
	end

	ply:GiveAmmo(9999, "Pistol", true)

	return true
end

-- Could be an issue depending on the gamemode
-- Prevents other players from being able to pick up the entity of the owner
-- Prevents all players from being able to pick up props
function GM:PhysgunPickup(ply, ent)
	if (ent.Owner == ply) then
		return true
	end

	return false
end

function checkForLevel(ply)
	local expToLevel = (ply:GetNWInt("playerLvl")*100)*2
	local curExp = ply:GetNWInt("playerExp")
	local curLvl = ply:GetNWInt("playerLvl")

	if (curExp >= expToLevel) then
		curExp = curExp - expToLevel

		ply:SetNWInt("playerExp", curExp)
		ply:SetNWInt("playerLvl", curLvl + 1)

		ply:PrintMessage(HUD_PRINTTALK, "Congratulations! You are now level " .. (curLvl + 1) .. ".")
	end
end

function GM:ShowSpare2(ply)
	ply:ConCommand("open_game_menu")
end

function GM:PlayerDisconnected(ply)
	ply:SetPData("playerLvl",ply:GetNWInt("playerLvl"))
	ply:SetPData("playerExp",ply:GetNWInt("playerExp"))
	ply:SetPData("playerMoney",ply:GetNWInt("playerMoney"))
	ply:SetPData("playerWeapon", ply:GetNWString("playerWeapon"))
end

function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		v:SetPData("playerLvl",v:GetNWInt("playerLvl"))
		v:SetPData("playerExp",v:GetNWInt("playerExp"))
		v:SetPData("playerMoney",v:GetNWInt("playerMoney"))
		v:SetPData("playerWeapon", v:GetNWString("playerWeapon"))
	end
end

function GM:GravGunPunt(player, entity)
	-- if (entity:GetClass() == "ammo_dispenser") then
	--     return false
	-- end              if we want to punt props but not entities
	return false
end
