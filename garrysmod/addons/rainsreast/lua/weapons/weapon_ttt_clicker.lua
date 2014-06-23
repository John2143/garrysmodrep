AddCSLuaFile()
SWEP.HoldType			= "rpg"

if CLIENT then
   SWEP.PrintName = "clickclickclick_name"
   SWEP.Slot = 1
   SWEP.Icon = "VGUI/ttt/icon_rpg"
end

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Sound = Sound( "Weapon_Pistol.Empty" )


SWEP.ViewModelFOV    = 60

SWEP.Primary.Delay			= 0.025
SWEP.Primary.Recoil			= 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Thumper"
SWEP.Primary.Damage = 0.333
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.AutoSpawnable      = false

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:SendWeaponAnim(self.PrimaryAnim)

   self.Owner:MuzzleFlash()
   self.Owner:SetAnimation( PLAYER_ATTACK1 )

   if not IsFirstTimePredicted() then return end

   local sights = self:GetIronsights()

   numbul = numbul or 1
   cone   = cone   or 0.01

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self.Owner:GetShootPos()
   bullet.Dir    = self.Owner:GetAimVector()
   bullet.Spread = Vector( cone, cone, 0 )
   bullet.Tracer = 1
   bullet.TracerName = "PhyscannonImpact"
   bullet.Force  = 10
   bullet.Damage = dmg

   self.Owner:FireBullets( bullet )

   -- Owner can die after firebullets
   if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 0.6) or recoil

      local eyeang = self.Owner:EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self.Owner:SetEyeAngles( eyeang )
   end

end

function SWEP:PrimaryAttack(worldsnd)
	if shotgundelay > CurTime() then return end
   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, 511 )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), 511 )
   end

   self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

   local owner = self.Owner
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
end
	

shotgundelay = 0
function SWEP:SecondaryAttack(worldsnd)
	if shotgundelay > CurTime() then return end
   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, 511 )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), 511 )
   end
   self:ShootEffects()
   self:ShootBullet( 0.22, self.Primary.Recoil, 100, 0.5 )

   local owner = self.Owner
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
   shotgundelay = CurTime() + 1
   	self.Weapon:EmitSound("Weapon_Shotgun.Double")
	timer.Simple( 0.4, function() self:shotguneffect() end )
   
end

function SWEP:shotguneffect()
	self.Weapon:EmitSound("Weapon_Shotgun.Special1")
	self.Weapon:SendWeaponAnim ( ACT_SHOTGUN_PUMP );
	timer.Simple( 0.25, function() self:SendWeaponAnim(ACT_VM_IDLE) end )
end

function SWEP:Reload()
end