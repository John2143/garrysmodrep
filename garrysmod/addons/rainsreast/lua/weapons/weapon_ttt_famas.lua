AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "Famas"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_famaser"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.09009009009
SWEP.Primary.Recoil			= 4
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Damage = 15
SWEP.Primary.Cone = 0.066
SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 25
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg_ttt"

SWEP.MovementPenalty = 0.04
SWEP.ResetTime = 0.6
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_famas.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Famas.Single" )

SWEP.IronSightsPos = Vector(-6.2, 0, 1)
SWEP.IronSightsAng = Vector(0, 0, -2)