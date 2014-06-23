AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "SMG"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_smger"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.075
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Damage = 9
SWEP.Primary.Cone = 0.05
SWEP.Primary.ClipSize = 45
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 45
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"

SWEP.Primary.Sound = Sound( "Weapon_SMG1.Single" )


SWEP.IronSightsPos = Vector(-6.43, -8.881, 1.039)
SWEP.IronSightsAng = Vector(0.1, -0.101, -0.201)