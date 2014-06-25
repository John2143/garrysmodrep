AddCSLuaFile()

if SERVER then
   resource.AddFile("materials/VGUI/ttt/ttt_manheckler.vmt")
end


if CLIENT then
	SWEP.PrintName = "Manhack"
	SWEP.Description = "A deployable, remotely controlled device.\nIdeal for scouting but also can be used for attacking from safety."

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 10
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = false

	SWEP.ViewModelBoneMods = {
		["ValveBiped.cube1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/manhack.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 4, 0), angle = Angle(-54.206, 58.294, -50.114), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/manhack.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 5, 0), angle = Angle(-43.978, 27.614, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Icon = "VGUI/ttt/ttt_manheckler"

SWEP.Base = "weapon_tttbase"

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/manhack.mdl"
SWEP.UseHands = true
SWEP.Category = "ZS"
SWEP.Spawnable = true
SWEP.HoldType = "grenade"

SWEP.WalkSpeed = SPEED_FAST

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "manhack"
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.LimitedStock = true

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.AllowDrop = false

SWEP.Slot = 6

SWEP.Kind = WEAPON_EQUIP1

SWEP.EquipMenuData = {
   type = "Weapon",
   desc = [[Hacks man
			Painfully
			
			Primary fire toggles manual control.
			Secondary fire explodes.]]
};



function SWEP:GetPrimaryAmmoCount()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1()
end

function SWEP:Initialize()
	self:SetWeaponHoldType("grenade")
	self:SetDeploySpeed(1.1)
end

function SWEP:CanPrimaryAttack()

	for _, ent in pairs(ents.FindByClass("prop_manhack")) do
		if ent:GetOwner() == self.Owner then return false end
	end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end



function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local owner = self.Owner
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()

	self:TakePrimaryAmmo(1)
	self.NextDeploy = CurTime() + 0.75

	if SERVER then
		local ent = ents.Create("prop_manhack")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetOwner(owner)
			ent:Spawn()
			ent:Activate()
			ent:EmitSound("WeaponFrag.Throw")
			ent.fingerprints = {self.Owner}
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(self.Owner:GetAimVector() * 200)
			end

			if not owner:HasWeapon("weapon_zs_manhackcontrol") then
				owner:Give("weapon_zs_manhackcontrol")
			end
			owner:SelectWeapon("weapon_zs_manhackcontrol")

			if self:GetPrimaryAmmoCount() <= 0 then
				owner:StripWeapon(self:GetClass())
			end
		end
		-- self.Owner.cManhack = ent
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:Deploy()

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SendWeaponAnim(ACT_VM_THROW)
	end

	return true
end

function SWEP:Holster()
	self.NextDeploy = nil
	return true
end

function SWEP:Think()
	if self.NextDeploy and self.NextDeploy <= CurTime() then
		self.NextDeploy = nil

		if 0 < self:GetPrimaryAmmoCount() then
			self:SendWeaponAnim(ACT_VM_DRAW)
		else
			self:SendWeaponAnim(ACT_VM_THROW)
			if SERVER then
				self:Remove()
			end
		end
	end
end