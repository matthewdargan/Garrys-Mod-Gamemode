include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    Ang:RotateAroundAxis(Ang:Up(), 90)

    local EntityName = "Basic Printer"
    local PrinterOwner = "PRINTER OWNER"
    local MoneyAmount = "MONEY AMOUNT"

    surface.SetFont("HudHintTextLarge")
    local EntityNameWidth = surface.GetTextSize(EntityName)

    surface.SetFont("HudHintTextSmall")
    local PrinterOwnerWidth = surface.GetTextSize(PrinterOwner)
    local MoneyAmountWidth = surface.GetTextSize(MoneyAmount)

    cam.Start3D2D(Pos + Ang:Up() * 5, Ang, 0.2)
        draw.WordBox(0, -EntityNameWidth * 0.5, -30, EntityName, "HudHintTextLarge", Color(0, 0, 0, 100), Color(255, 255, 255, 255))
        draw.WordBox(0, -PrinterOwnerWidth * 0.5, -10, PrinterOwner, "HudHintTextSmall", Color(0, 0, 0, 100), Color(255, 255, 255, 255))
        draw.WordBox(0, -MoneyAmountWidth * 0.5, 1, MoneyAmount, "HudHintTextSmall", Color(0, 0, 0, 100), Color(255, 255, 255, 255))
    cam.End3D2D()
end
