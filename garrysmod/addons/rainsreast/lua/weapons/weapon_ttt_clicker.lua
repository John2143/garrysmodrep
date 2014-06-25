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

SWEP.Primary.Delay			= 0.0000
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
	//if CLIENT and sparkle:GetBool() then
      //bullet.Callback = Sparklies
    //end

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
   
   self.Owner:MuzzleFlash()
   self.Owner:SetAnimation( PLAYER_ATTACK1 )
   if not worldsnd then
      self:EmitSound( self.Primary.Sound, 511 )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), 511 )
   end

   self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

end

	


shotgundelay = 0
function SWEP:SecondaryAttack(worldsnd)
	if shotgundelay > CurTime() then return end
	shotgundelay = CurTime() + 1
	self:SetNextPrimaryFire( CurTime() + 1 )

	timer.Simple(0.0, function() if self and self.DoSecondary then self:DoSecondary() end end)

end

	
function SWEP:DoSecondary()
	if !(self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner:Alive()) then return end
	if CLIENT then
		if self.Weapon then
			self.Weapon:EmitSound("Weapon_Shotgun.Double")
		end
	else
		self:ShootBullet( 0.22, self.Primary.Recoil, 100, 0.5 )
		sound.Play("Weapon_Shotgun.Double", self.Owner:GetPos())
		timer.Simple(0.4, function() if self and self.MakeNoise then self:MakeNoise() end end)
	end
end

function SWEP:MakeNoise()
	if !(self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner:Alive()) then return end
	sound.Play("Weapon_Shotgun.Special1", self.Owner:GetPos())
end

function SWEP:Reload()

end