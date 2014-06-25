AddCSLuaFile()

SWEP.HoldType			= "ar2"

if CLIENT then
   SWEP.PrintName			= "Pulse Rifle"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_polter"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.15
SWEP.Primary.Recoil			= 2
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Damage = 19
SWEP.Primary.Cone = 0.066
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.MovementPenalty = 0.03
SWEP.ResetTime = 1.4
SWEP.BaseInaccuracy = 0

SWEP.Tracer = "AR2Tracer"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 50
SWEP.ViewModel			= "models/weapons/c_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Primary.Sound = Sound( "Weapon_AR2.Single" )

SWEP.IronSightsPos = Vector(-4, -10, 2)
SWEP.IronSightsAng = Vector(0, 0, 0)


--[[ function SWEP:DoShootEffect( hitpos, hitnormal, entity, physbone, bFirstTimePredicted )
	
	if ( !bFirstTimePredicted ) then return end	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( hitpos )
		effectdata:SetNormal( hitnormal )
		effectdata:SetEntity( entity )
		effectdata:SetAttachment( physbone )
	util.Effect( "AR2Impact", effectdata )
	
end ]]
