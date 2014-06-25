AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "Galil"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_galiler"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.09
SWEP.Primary.Recoil			= 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 12
SWEP.Primary.Cone = 0.06
SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 25
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.04
SWEP.ResetTime = 0.8
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_galil.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Galil.Single" )

SWEP.IronSightsPos = Vector(-6.38, -6, 2.5)
SWEP.IronSightsAng = Vector(0, 0, 0)