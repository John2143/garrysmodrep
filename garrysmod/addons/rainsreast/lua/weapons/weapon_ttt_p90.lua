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
SWEP.Primary.Damage = 14
SWEP.Primary.Cone = 0.15
SWEP.Primary.ClipSize = 50
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 50
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.MovementPenalty = 0.06
SWEP.ResetTime = 0.7
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_p90.mdl"

SWEP.Primary.Sound = Sound( "Weapon_P90.Single" )

SWEP.IronSightsPos = Vector(-5.7, -8.04, 1.8)
SWEP.IronSightsAng = Vector(0, 0, 0)