local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() local PepsisWorld = Library:CreateWindow({ Name = "FemWare v1.0.0", Themeable = true, Info = "" })

local GeneralTab = PepsisWorld:CreateTab({ Name = "General" }) local VisualTab = PepsisWorld:CreateTab({ Name = "Visual" }) local MiscTab = PepsisWorld:CreateTab({ Name = "Misc" })

local AimbotSection = GeneralTab:CreateSection({ Name = "Aimbot" }) local PlayerSection = GeneralTab:CreateSection({ Name = "Player Changes" }) local WorldSection = GeneralTab:CreateSection({ Name = "World Changes" }) local VisualSection = VisualTab:CreateSection({ Name = "ESP" }) local GunSection = MiscTab:CreateSection({ Name = "Gun Changes" })

local targetPart = "Head"

local function ClosestChar() local Players = game.Players local LocalPlayer = Players.LocalPlayer local GetPlayers = Players.GetPlayers local Camera = workspace.CurrentCamera local WTSP = Camera.WorldToScreenPoint local FindFirstChild = game.FindFirstChild local Vector2_new = Vector2.new local Mouse = LocalPlayer:GetMouse()

local Max, Close = math.huge
for _, V in pairs(GetPlayers(Players)) do
    if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
        local Part = FindFirstChild(V.Character, targetPart)
        if Part then
            local Pos, OnScreen = WTSP(Camera, Part.Position)
            if OnScreen then
                local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
                if Dist < Max then
                    Max = Dist
                    Close = V.Character
                end
            end
        end
    end
end
return Close

end

local MT = getrawmetatable(game) local __namecall = MT.__namecall setreadonly(MT, false)

MT.__namecall = newcclosure(function(self, ...) local Method = getnamecallmethod() if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then local Character = ClosestChar() if Character then return Character[targetPart], Character[targetPart].Position end end return __namecall(self, ...) end)

setreadonly(MT, true)

local AimbotToggle = AimbotSection:CreateToggle({ Name = "Aimbot", Flag = "AimbotSection_AimbotToggle", Callback = function() end })

local TargetSwitchButton = AimbotSection:CreateButton({ Name = "Trocar mira (Cabeça/Torso)", Callback = function() if targetPart == "Head" then targetPart = "Torso" game.StarterGui:SetCore("SendNotification", { Title = "Aimbot Alterado", Text = "Agora mirando no Torso", Duration = 2 }) else targetPart = "Head" game.StarterGui:SetCore("SendNotification", { Title = "Aimbot Alterado", Text = "Agora mirando na Cabeça", Duration = 2 }) end end })

local EspPlayersToggle = VisualSection:CreateToggle({ Name = "ESP Players", Flag = "VisualSection_ESPPlayers", Callback = function() local PlayerManager, Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/PlayerManager.lua"))() local Manager = PlayerManager.new() Base.Box.GlobalLookAtCamera = true Manager:Start() end })

local NoDoorsButton = WorldSection:CreateButton({
  Name = "No-Doors",
  Flag = "WorldSection_NoDoors",
  Callback = function()
    game.Workspace.Doors:Destroy()
})
local InfAmmoButton = GunSection:CreateButton({
  Name = "Infinite Ammo (M9)",
  Flag = "GunSection_InfAmmo",
  Callback = function()
    local plr = game.Players.LocalPlayer
    local gun = plr.Backpack.M9.GunStates
    local a = require(gun)
    a.MaxDamage = math.huge
    a.CurrentAmmo = math.huge
    a.MaxAmmo = math.huge
  end
})
