AddCSLuaFile()

SWEP.HoldType			= "pistol"

if CLIENT then
   SWEP.PrintName			= ".357 Magnum"
   SWEP.Slot				= 1

   SWEP.Icon = "vgui/ttt/icon_magnumer"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay			= 0.75
SWEP.Primary.Recoil			= 13
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 44
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 6
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/c_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.Primary.Sound = Sound( "Weapon_357.Single" )

SWEP.IronSightsPos = Vector(-4.676, -11.565, 0.643)
SWEP.IronSightsAng = Vector(0.3, -0.201, 0.3)