AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "MP5"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_mp5er"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.08
SWEP.Primary.Recoil			= 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 14
SWEP.Primary.Cone = 0.1
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.02
SWEP.ResetTime = 0.5
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mp5.mdl"

SWEP.Primary.Sound = Sound( "Weapon_MP5Navy.Single" )

SWEP.IronSightsPos = Vector(-5.361, -7, 1.72)
SWEP.IronSightsAng = Vector(1.7, 0, 0)