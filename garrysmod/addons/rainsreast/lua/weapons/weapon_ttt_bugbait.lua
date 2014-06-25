AddCSLuaFile()

SWEP.HoldType			= "grenade"

if CLIENT then
   SWEP.PrintName			= "Bugbait"
   SWEP.Slot				= 3
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_NADE

SWEP.Primary.Delay			= 0.5
SWEP.Primary.Recoil			= 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = nil
SWEP.Primary.Damage = 0
SWEP.Primary.Cone = 0.015
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = nil

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/c_bugbait.mdl"
SWEP.WorldModel			= "models/weapons/w_bugbait.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Bugbait.Single" )

nextthrow = 0

function SWEP:PrimaryAttack()
	if nextthrow > CurTime() then return end
	nextthrow = CurTime() + 1.2

	local owner = self.Owner
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()
	timer.Simple(0.2, function() if self and owner then self:SendWeaponAnim(ACT_VM_DRAW) end end)
	if SERVER then
		local ent = ents.Create("npc_grenade_bugbait")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetOwner(owner)
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:SetVelocity( ent:GetForward() * 100)
			ent:SetGravity(0.0001)
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()


			end
			
		end
	end
end
function SWEP:SecondaryAttack()
	if nextthrow > CurTime() then return end
	nextthrow = CurTime() + 0.6

	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	
	self:EmitSound("weapons/bugbait/bugbait_squeeze"..math.random(1, 3)..".wav")
	
	timer.Simple(0.4, function() if self and self.Owner then self:SendWeaponAnim(ACT_VM_IDLE) end end)
			
	end

