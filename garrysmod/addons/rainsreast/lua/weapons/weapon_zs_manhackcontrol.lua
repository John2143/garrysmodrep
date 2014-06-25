AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Manhack Control"
	SWEP.Description = "Controller for your Manhack."

	SWEP.ViewModelFOV = 50

	SWEP.BobScale = 0.5
	SWEP.SwayScale = 0.5

	SWEP.Slot = 4
	SWEP.SlotPos = 0
end

SWEP.Base = "weapon_tttbase"
SWEP.Slot = 7

SWEP.Kind = WEAPON_EQUIP2

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true

SWEP.Primary.Delay = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Delay = 20
SWEP.Secondary.Heal = 10

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_FAST

SWEP.NoMagazine = true
SWEP.Undroppable = true
SWEP.NoPickupNotification = true

SWEP.HoldType = "slam"

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(10)
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	if SERVER then
		for _, ent in pairs(ents.FindByClass("prop_manhack")) do
			if ent:GetOwner() == self.Owner then
				return
			end
		end

		self.Owner:StripWeapon(self:GetClass())
	end
end

function SWEP:PrimaryAttack()
	if IsFirstTimePredicted() then
		self:SetDTBool(0, not self:GetDTBool(0))

		if CLIENT then
			LocalPlayer():EmitSound(self:GetDTBool(0) and "buttons/button17.wav" or "buttons/button19.wav", 0)
		end
	end
end

function SWEP:SecondaryAttack()
	local manhack
	for _, ent in pairs(ents.FindByClass("prop_manhack")) do
		if ent:GetOwner() == self.Owner then manhack = ent end
	end
	if CLIENT or !manhack then return end
	local ent = ents.Create( "env_explosion" )
	ent:SetPos( manhack:GetPos() )
	ent:SetOwner( self.Owner )
	ent:Spawn()
	ent:SetKeyValue( "iMagnitude", "99" )
	manhack:Destroy()
	ent:Fire( "Explode", 0, 0 )
	
end

function SWEP:Reload()
	return false
end
	
function SWEP:Deploy()

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:Holster()
	self:SetDTBool(0, false)

	return true
end

function SWEP:Reload()
end

