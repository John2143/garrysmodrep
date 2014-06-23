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
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 17
SWEP.Primary.Cone = 0.03
SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 25
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_galil.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Galil.Single" )

SWEP.IronSightsPos = Vector(-1.961, -6, 2.839)
SWEP.IronSightsAng = Vector(0, 0, 0)