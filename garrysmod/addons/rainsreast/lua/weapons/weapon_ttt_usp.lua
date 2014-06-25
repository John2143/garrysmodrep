AddCSLuaFile()

SWEP.HoldType			= "pistol"

if CLIENT then
   SWEP.PrintName			= "USP"
   SWEP.Slot				= 1

   SWEP.Icon = "vgui/ttt/icon_usper"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay			= 0.5
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 23
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 16
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 12
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.01
SWEP.ResetTime = 0.7
SWEP.BaseInaccuracy = 0


SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.Primary.Sound = Sound( "Weapon_USP.Single" )

SWEP.IronSightsPos = Vector(-5.881, -10.521, 2.72)
SWEP.IronSightsAng = Vector(-0.201, 0.1, 0)