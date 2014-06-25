
AddCSLuaFile()
 
SWEP.HoldType = "pistol"
   

if CLIENT then
   SWEP.PrintName = "pistol_name"
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_pistol"
	local ang = Angle(0,0,0)
	ang:RotateAroundAxis(ang:Right(), -90)
	SWEP.HUD3DAng = ang
	SWEP.HUD3DBone = "v_weapon.FIVESEVEN_PARENT"
	SWEP.HUD3DPos = Vector(-.6, -2.3, 0)
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 1.5
SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.38
-- SWEP.MovementPenalty = .03
SWEP.ResetTime = .75
SWEP.BaseInaccuracy = 0.01
SWEP.Cone = .01
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.MovementPenalty = 0.04
SWEP.ResetTime = 0.4
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

SWEP.Primary.Sound = Sound( "Weapon_FiveSeven.Single" )
SWEP.IronSightsPos = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng = Vector(0, 0, 0)
