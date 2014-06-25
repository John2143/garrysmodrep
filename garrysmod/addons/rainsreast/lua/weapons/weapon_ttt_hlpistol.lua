AddCSLuaFile()
SWEP.HoldType			= "pistol"

if SERVER then
resource.AddFile("VGUI/ttt/icon_hlpistol.vmt")
end

if CLIENT then
   SWEP.PrintName = "Pistol"
   SWEP.Slot = 1
   SWEP.Icon = "VGUI/ttt/icon_hlpistol"
end

SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay			= 0.1
SWEP.Primary.Recoil			= 2.2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 14
SWEP.Primary.Cone = 0.044
SWEP.Primary.ClipSize = 18
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 18
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.07
SWEP.ResetTime = 0.5
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Pistol.Single" )


SWEP.IronSightsPos = Vector(-5.9, -5, 3.079)
SWEP.IronSightsAng = Vector(0, -1.2, 1.399)

function SWEP:Reload()
	if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
   self:DefaultReload(self.ReloadAnim)
   self:EmitSound("Weapon_Pistol.Reload")
   self:SetIronsights( false )
end
