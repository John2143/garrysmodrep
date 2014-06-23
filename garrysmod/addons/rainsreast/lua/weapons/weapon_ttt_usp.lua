AddCSLuaFile()

SWEP.HoldType			= "pistol"

if CLIENT then
   SWEP.PrintName			= "USP"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_usper"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.15
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 16
SWEP.Primary.Cone = 0.015
SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 12
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.Primary.Sound = Sound( "Weapon_USP.Single" )

SWEP.IronSightsPos = Vector(-5.881, -10.521, 2.72)
SWEP.IronSightsAng = Vector(-0.201, 0.1, 0)