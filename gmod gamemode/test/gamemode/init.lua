AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("testhud.lua")

include( "shared.lua" )


function GM:PlayerSpawn(ply)

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

end

function GM:PlayerInitialSpawn()

end

function GM:OnNPCKilled(npc, attacker, inflictor)

	-- add money 
	-- add exp and check for level up

	attacker:SetNWInt("money", attacker:GetNWInt("money") + 50)

end

function GM:PlayerDeath(victim, inflictor, attacker)

	attacker:SetNWInt("money", attacker:GetNWInt("money") + 50)
	
end