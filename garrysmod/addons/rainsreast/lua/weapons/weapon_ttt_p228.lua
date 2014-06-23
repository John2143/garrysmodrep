AddCSLuaFile()

SWEP.HoldType			= "pistol"

if CLIENT then
   SWEP.PrintName			= "P228"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_p228er"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay			= 0.15
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 19
SWEP.Primary.Cone = 0.015
SWEP.Primary.ClipSize = 13
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 13
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"

SWEP.Primary.Sound = Sound( "Weapon_P228.Single" )

SWEP.IronSightsPos = Vector(-5.961, -10.521, 2.92)
SWEP.IronSightsAng = Vector(-0.7, 0, 0)