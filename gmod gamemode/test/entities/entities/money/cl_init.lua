include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local Pos = self:GetPos()
    local Ange = self:GetAngles()

    local value = self:GetValue()

    surface.SetFont("HudHintTextSmall")
    local ValueWidth = surface.GetTextSize(Value)

    cam.Start3D2D(Pos + Ang:Up(), Ang, 0.2)
        draw.WordBox(0, -ValueWidth * 0.5, -7, "$" .. Value, "HudHintTextSmall", Color(0, 0, 0, 200), Color(255, 255, 255, 255))
    cam.End3D2D()
end
