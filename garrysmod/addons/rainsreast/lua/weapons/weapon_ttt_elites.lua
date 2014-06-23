AddCSLuaFile()

SWEP.HoldType			= "fist"

if CLIENT then
   SWEP.PrintName			= "Elites"
   SWEP.Slot				= 1

   SWEP.Icon = "vgui/ttt/icon_eliter"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay			= 0.08
SWEP.Primary.Recoil			= 2.666
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 17
SWEP.Primary.Cone = 0.05
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_elite.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Elite.Single" )