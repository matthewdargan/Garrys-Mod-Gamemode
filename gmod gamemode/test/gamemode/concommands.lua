function buyEntity(ply, cmd, args)
    if (args[1] != nil) then
        local ent = ents.Create(args[1])
        local tr = ply:GetEyeTrace()
        local balance = ply:GetNWInt("playerMoney")

        if (ent:IsValid()) then
            local ClassName = ent:GetClass()

            if (!tr.Hit) then return end

            local entCount = ply:GetNWInt(ClassName .. "count")

            -- !IsValid(ent.Limit) might be causing error with spawning ammo_dispenser
            -- Fix this error and then commit to github
            if (ent.Limit == nil or entCount < ent.Limit) then
                if (balance >= ent.Cost) then
                    local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

                    ent.Owner = ply

                    ent:SetPos(SpawnPos)
                    ent:Spawn()
                    ent:Activate()

                    ply:SetNWInt("playerMoney", balance - ent.Cost)
                    ply:SetNWInt(ClassName .. "count", entCount + 1)

                    return ent
                else
                    ply:PrintMessage(HUD_PRINTTALK, "You do not have enough money to purchase this item.")
                end
            else
                ply:PrintMessage(HUD_PRINTTALK, "You already have the maximum amount of this entity type. MAX = " .. ent.Limit)
            end

            return
        end
    end
end
concommand.Add("buy_entity", buyEntity)

function buyGun(ply, cmd, args)
    -- Add any new weapons to this array below, for example...
    -- weaponPrices[2] = {"weapon_name_here", "weapon_cost_here", "weapon_level_requirement"}
    local weaponPrices = {}
    weaponPrices[1] = {"weapon_shotgun", "200", "5"}

    for k, v in pairs(weaponPrices) do
        if (args[1] == v[1]) then
            local balance = ply:GetNWInt("playerMoney")
            local playerLvl = ply:GetNWInt("playerLvl")
            local gunCost = tonumber(v[2])
            local levelReq = tonumber(v[3])

            if (playerLvl >= levelReq) then
                if (balance >= gunCost) then
                    ply:SetNWInt("playerMoney", balance - gunCost)
                    ply:SetNWString("playerWeapon", args[1])
                    ply:Give(args[1])
                    ply:GiveAmmo(20, ply:GetWeapon(args[1]):GetPrimaryAmmoType(), false)
                else
                    ply:PrintMessage(HUD_PRINTTALK, "You do not have enough money to purchase this item.")
                end
            else
                ply:PrintMessage(HUD_PRINTTALK, "You must be level " .. levelReq .. " to purchase this item.")
            end

            return
        end
    end
end
concommand.Add("buy_gun", buyGun)

function upgradePrintAmount(ply, cmd, args)
    local entity = Entity(args[1])
    local printAmount = entity:GetPrintAmount()
    local upgradeCost = printAmount * 2
    local plyBal = ply:GetNWInt("playerMoney")

    if (plyBal >= upgradeCost) then
        ply:SetNWInt("playerMoney", plyBal - upgradeCost)

        entity:SetPrintAmount(printAmount + 20)
    end
end
concommand.Add("upgrade_print_amount", upgradePrintAmount)

function setPlayerClass(ply, cmd, args)
    ply:SetNWInt("playerClass", tonumber(args[1]))

    ply:Spawn()
end
concommand.Add("set_player_class", setPlayerClass)
