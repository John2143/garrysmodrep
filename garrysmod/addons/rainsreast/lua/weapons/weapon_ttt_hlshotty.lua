AddCSLuaFile()

SWEP.HoldType			= "shotgun"

if CLIENT then
   SWEP.PrintName			= "Shotgun"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_hlshotty"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Damage = 8
SWEP.Primary.Cone = 0.2
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 6
SWEP.Primary.NumShots = 7
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Shotgun.Single" )
SWEP.Secondary.Sound = Sound( "Weapon_Shotgun.Double" )


SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0

SWEP.ReloadDelay = 0.4
SWEP.IdleAnimation = 0

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
	timer.Simple( 0.05, function() self:SendWeaponAnim(ACT_VM_IDLE) end )
	return true
end

function SWEP:Reload()
	if self.reloading then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:SetNextPrimaryFire(CurTime() + self.ReloadDelay)
		self.reloading = true
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.Owner:DoReloadEvent()
	end
end

	
function SWEP:shotguneffect()
	if !(self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner:Alive()) then return end
	self.Weapon:EmitSound("Weapon_Shotgun.Special1")
	self.Weapon:SendWeaponAnim ( ACT_SHOTGUN_PUMP );
	timer.Simple( 0.25, function() if self and self.SendWeaponAnim then self:SendWeaponAnim(ACT_VM_IDLE) end end )
end

function SWEP:PrimaryAttack(worldsnd)

   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
   end

   self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

   self:TakePrimaryAmmo( 1 )

   local owner = self.Owner
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
   
	timer.Simple(0.4, function() if self and self.shotguneffect then self:shotguneffect() end end)
	end
	
function SWEP:SecondaryAttack()
	if ( !self:CanSecondaryAttack() ) then self:PrimaryAttack() 
		return end
	self.ShootEffects2( self )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.8 )	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
	
	self:ShootBullet( 6, 15, self.Primary.NumShots * 2, self:GetPrimaryCone() )
	
	self:TakePrimaryAmmo( 2 )
		self.Owner:ViewPunch( Angle( -6, 0, 0 ) )
	self.Weapon:EmitSound("Weapon_Shotgun.Double")
	timer.Simple( 0.25, function() if self and self.shotguneffect then self:shotguneffect() end end )
end	
function SWEP:ShootEffects2()
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )  -- View model animation
	self.Owner:MuzzleFlash() -- Crappy muzzle light
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
end
if SERVER then
function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.nextreloadfinish = 0
	timer.Simple( 0.05, function() self:SendWeaponAnim(ACT_VM_IDLE) end )
	end

	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	end
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)
   
   -- decay from 3.1 to 1 slowly as distance increases
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end

if CLIENT then
function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.nextreloadfinish = 0
	timer.Simple( 0.05, function() self:SendWeaponAnim(ACT_VM_IDLE) end )
	end

	end
end

function SWEP:CanPrimaryAttack()

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	if self.reloading then
		if self:Clip1() < self.Primary.ClipSize then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		else

		end
		self.reloading = false
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	return self:GetNextPrimaryFire() >= CurTime()
end

function SWEP:CanSecondaryAttack()
	if ( self.Weapon:Clip1() <= 1 ) then
		return false
	end
	return true
end

