AddCSLuaFile()
SWEP.HoldType			= "rpg"

if CLIENT then
   SWEP.PrintName = "clickclickclick_name"
   SWEP.Slot = 1
end

SWEP.Base = "weapon_tttbase"

SWEP.Primary.Sound = Sound( "Weapon_Pistol.Empty" )

SWEP.Primary.Delay			= 0.1
SWEP.Primary.Recoil			= 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 0.5
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = 1337
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1337
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_grenade"

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rpg.mdl"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false