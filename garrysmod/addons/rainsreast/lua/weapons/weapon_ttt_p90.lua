AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "P90"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_p90er"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.07001166861
SWEP.Primary.Recoil			= 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Damage = 10
SWEP.Primary.Cone = 0.015
SWEP.Primary.ClipSize = 50
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 50
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_p90.mdl"

SWEP.Primary.Sound = Sound( "Weapon_P90.Single" )

SWEP.IronSightsPos = Vector(-2.76, -8.04, 2.92)
SWEP.IronSightsAng = Vector(0, 0, 0)