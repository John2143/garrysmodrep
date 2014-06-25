local meta = FindMetaTable("Weapon")
if not meta then return end
if SERVER then
   resource.AddFile("materials/VGUI/ttt/turretnosuck.vmt")
end
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/Combine_turrets/Floor_turret.mdl"

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "thumper"
SWEP.Primary.Delay = 2

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL
SWEP.FullWalkSpeed = SPEED_SLOWEST
SWEP.Base = "weapon_tttbase"
SWEP.Icon = "VGUI/ttt/turretnosuck"
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.AllowDrop = false

SWEP.EquipMenuData = {
   type = "Weapon",
   desc = [[Shoots things. With style.
			Secondary fire toggles manual control.
			Reload fires rpg_missile's.]]
};

function meta:GetPrimaryAmmoCount()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1()
end
function meta:HideWorldModel()
	self:DrawShadow(false)
	self.DrawWorldModel = empty
	self.DrawWorldModelTranslucent = empty
end

function meta:HideViewAndWorldModel()
	self:HideViewModel()
	self:HideWorldModel()
end
function meta:HideViewModel()
	self.GetViewModelPosition = NULLViewModelPosition
end
function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	self:SetDeploySpeed(1.1)
	self:HideViewAndWorldModel()
end

function SWEP:SetReplicatedAmmo(count)
	self:SetDTInt(0, count)
end

function SWEP:GetReplicatedAmmo()
	return self:GetDTInt(0)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:CanPrimaryAttack()

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	if SERVER then
		local count = self:GetPrimaryAmmoCount()
		if count ~= self:GetReplicatedAmmo() then
			self:SetReplicatedAmmo(count)
		end
	end
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:Holster()
	return true
end

util.PrecacheModel("models/Combine_turrets/Floor_turret.mdl")
