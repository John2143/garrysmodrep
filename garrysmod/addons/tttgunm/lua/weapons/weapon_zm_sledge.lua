
AddCSLuaFile()

SWEP.HoldType			= "crossbow"


if CLIENT then

   SWEP.PrintName			= "H.U.G.E-249"

   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_m249"

   SWEP.ViewModelFlip		= false
   
	-- SWEP.HUD3DBone = "v_weapon.m249"
	-- local ang = Angle(0,0,0)
	-- ang:RotateAroundAxis(ang:Right(), 0)
	-- ang:RotateAroundAxis(ang:Forward(), 0)
	-- SWEP.HUD3DPos = Vector(0,0,0)
	-- SWEP.HUD3DAng = ang
	-- SWEP.HUD3DScale = 0.1
	
	--?????????????????????????????????????????????????
end


SWEP.Base				= "weapon_tttbase"

SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249


SWEP.Primary.Damage = 7
SWEP.Primary.Delay = 0.06
SWEP.MovementPenalty = 0.01
SWEP.ResetTime = 1.4
SWEP.BaseInaccuracy = 0.07
SWEP.Cone = .02
SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.AutoSpawnable      = true
SWEP.Primary.Recoil			= 1.9
SWEP.Primary.Sound			= Sound("Weapon_m249.Single")

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 65
SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng = Vector(0, 0, 0)
