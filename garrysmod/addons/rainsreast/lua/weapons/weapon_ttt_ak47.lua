AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "AK47"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_ak47erer"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.1
SWEP.Primary.Recoil			= 6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Damage = 17
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 24
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 24
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.07
SWEP.ResetTime = 2
SWEP.BaseInaccuracy = 0


SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"

SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" )

SWEP.IronSightsPos = Vector(-3.08, -15.08, 3.519)
SWEP.IronSightsAng = Vector(2.7, 0.1, 0.6)