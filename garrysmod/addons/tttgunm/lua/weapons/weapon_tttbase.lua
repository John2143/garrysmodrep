-- Custom weapon base, used to derive from CS one, still very similar

AddCSLuaFile()

local TESTINGSTRANGES = false
---- TTT SPECIAL EQUIPMENT FIELDS

-- This must be set to one of the WEAPON_ types in TTT weapons for weapon
-- carrying limits to work properly. See /gamemode/shared.lua for all possible
-- weapon categories.
SWEP.Kind = WEAPON_NONE

-- If CanBuy is a table that contains ROLE_TRAITOR and/or ROLE_DETECTIVE, those
-- players are allowed to purchase it and it will appear in their Equipment Menu
-- for that purpose. If CanBuy is nil this weapon cannot be bought.
--   Example: SWEP.CanBuy = { ROLE_TRAITOR }
-- (just setting to nil here to document its existence, don't make this buyable)
SWEP.CanBuy = nil

if CLIENT then
   -- If this is a buyable weapon (ie. CanBuy is not nil) EquipMenuData must be
   -- a table containing some information to show in the Equipment Menu. See
   -- default equipment weapons for real-world examples.
   SWEP.EquipMenuData = nil

   -- Example data:
   -- SWEP.EquipMenuData = {
   --
   ---- Type tells players if it's a weapon or item
   --     type = "Weapon",
   --
   ---- Desc is the description in the menu. Needs manual linebreaks (via \n).
   --     desc = "Text."
   -- };

   -- This sets the icon shown for the weapon in the DNA sampler, search window,
   -- equipment menu (if buyable), etc.
   SWEP.Icon = "vgui/ttt/icon_nades" -- most generic icon I guess

   -- You can make your own weapon icon using the template in:
   --   /garrysmod/gamemodes/terrortown/template/

   -- Open one of TTT's icons with VTFEdit to see what kind of settings to use
   -- when exporting to VTF. Once you have a VTF and VMT, you can
   -- resource.AddFile("materials/vgui/...") them here. GIVE YOUR ICON A UNIQUE
   -- FILENAME, or it WILL be overwritten by other servers! Gmod does not check
   -- if the files are different, it only looks at the name. I recommend you
   -- create your own directory so that this does not happen,
   -- eg. /materials/vgui/ttt/mycoolserver/mygun.vmt
end

---- MISC TTT-SPECIFIC BEHAVIOUR CONFIGURATION

-- ALL weapons in TTT must have weapon_tttbase as their SWEP.Base. It provides
-- some functions that TTT expects, and you will get errors without them.
-- Of course this is weapon_tttbase itself, so I comment this out here.
--  SWEP.Base = "weapon_tttbase"

-- If true AND SWEP.Kind is not WEAPON_EQUIP, then this gun can be spawned as
-- random weapon by a ttt_random_weapon entity.
SWEP.AutoSpawnable = false

-- Set to true if weapon can be manually dropped by players (with Q)
SWEP.AllowDrop = true

-- Set to true if weapon kills silently (no death scream)
SWEP.IsSilent = false

-- If this weapon should be given to players upon spawning, set a table of the
-- roles this should happen for here
--  SWEP.InLoadoutFor = { ROLE_TRAITOR, ROLE_DETECTIVE, ROLE_INNOCENT }

-- DO NOT set SWEP.WeaponID. Only the standard TTT weapons can have it. Custom
-- SWEPs do not need it for anything.
--  SWEP.WeaponID = nil

---- YE OLDE SWEP STUFF

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = true
   SWEP.CSMuzzleFlashes = true
end

SWEP.Base = "weapon_base"

SWEP.Category           = "TTT"
SWEP.Spawnable          = false

SWEP.IsGrenade = false

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.Primary.Sound          = Sound( "Weapon_Pistol.Empty" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 1
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Primary.ClipMax        = -1

SWEP.Secondary.ClipSize     = 1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.ClipMax      = -1

SWEP.HeadshotMultiplier = 2.7

SWEP.StoredAmmo = 0
SWEP.IsDropped = false

SWEP.DeploySpeed = 1.4

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.fingerprints = {}

local sparkle = CLIENT and CreateConVar("ttt_crazy_sparks", "0", FCVAR_ARCHIVE)

-- crosshair
if CLIENT then
   local sights_opacity = CreateConVar("ttt_ironsights_crosshair_opacity", "0.8", FCVAR_ARCHIVE)
   local crosshair_brightness = CreateConVar("ttt_crosshair_brightness", "1.0", FCVAR_ARCHIVE)
   local crosshair_size = CreateConVar("ttt_crosshair_size", "1.0", FCVAR_ARCHIVE)
   local disable_crosshair = CreateConVar("ttt_disable_crosshair", "0", FCVAR_ARCHIVE)


	function SWEP:DrawHUD()
		local client = LocalPlayer()
		if disable_crosshair:GetBool() or (not IsValid(client)) then return end

		local sights = (not self.NoSights) and self:GetIronsights()

		local x = ScrW() / 2.0
		local y = ScrH() / 2.0
		local scale = 20 * self:CalculateCone()

		local LastShootTime = self:LastShootTime()
		scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

		local alpha = sights and sights_opacity:GetFloat() or 1
		local bright = crosshair_brightness:GetFloat() or 1

		-- somehow it seems this can be called before my player metatable
		-- additions have loaded
		local length = (25 * crosshair_size:GetFloat()) * scale * .5 + 5
		local gap = scale * 5 + 5
		if client.IsTraitor and client:IsTraitor() then
		 surface.SetDrawColor(255 * bright,
							  50 * bright,
							  50 * bright,
							  255 * (self.BaseInaccuracy == 0 and scale * .5 or 1))
		else
		 surface.SetDrawColor(0,
							  255 * bright,
							  0,
							  255 * (self.BaseInaccuracy == 0 and scale * .5 or 1))
		end

		surface.DrawLine( x - length - gap, y, x - gap, y )
		surface.DrawLine( x + length + gap, y, x + gap, y )
		surface.DrawLine( x, y - length - gap, x, y - gap )
		surface.DrawLine( x, y + length + gap, x, y + gap )
		if scale < 2 and self.BaseInaccuracy == 0 then
			surface.SetDrawColor(255*bright,
							  255*bright,
							  0,
							  150 - (scale*150*2))
			surface.DrawLine( x - 3, y, x - 10, y )
			surface.DrawLine( x + 3, y, x + 10, y )
			surface.DrawLine( x, y - 3, x, y - 10 )
			surface.DrawLine( x, y + 3, x, y + 10 )
		end
		if self.HUDHelp then
			self:DrawHelp()
		end
	end

   local GetTranslation  = LANG.GetTranslation
   local GetPTranslation = LANG.GetParamTranslation

   -- Many non-gun weapons benefit from some help
   local help_spec = {text = "", font = "TabLarge", xalign = TEXT_ALIGN_CENTER}
   function SWEP:DrawHelp()
      local data = self.HUDHelp

      local translate = data.translatable
      local primary   = data.primary
      local secondary = data.secondary

      if translate then
         primary   = primary   and GetPTranslation(primary,   data.translate_params)
         secondary = secondary and GetPTranslation(secondary, data.translate_params)
      end

      help_spec.pos  = {ScrW() / 2.0, ScrH() - 40}
      help_spec.text = secondary or primary
      draw.TextShadow(help_spec, 2)

      -- if no secondary exists, primary is drawn at the bottom and no top line
      -- is drawn
      if secondary then
         help_spec.pos[2] = ScrH() - 60
         help_spec.text = primary
         draw.TextShadow(help_spec, 2)
      end
   end

   -- mousebuttons are enough for most weapons
   local default_key_params = {
      primaryfire   = Key("+attack",  "LEFT MOUSE"),
      secondaryfire = Key("+attack2", "RIGHT MOUSE"),
      usekey        = Key("+use",     "USE")
   };

   function SWEP:AddHUDHelp(primary_text, secondary_text, translate, extra_params)
      extra_params = extra_params or {}

      self.HUDHelp = {
         primary = primary_text,
         secondary = secondary_text,
         translatable = translate,
         translate_params = table.Merge(extra_params, default_key_params)
      };
   end
end

-- Shooting functions largely copied from weapon_cs_base
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
end

function SWEP:DryFire(setnext)
   if CLIENT and LocalPlayer() == self.Owner then
      self:EmitSound( "Weapon_Pistol.Empty" )
   end

   setnext(self, CurTime() + 0.2)

   self:Reload()
end

function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end

   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
end

function SWEP:CanSecondaryAttack()
   if not IsValid(self.Owner) then return end

   if self:Clip2() <= 0 then
      self:DryFire(self.SetNextSecondaryFire)
      return false
   end
   return true
end

local function Sparklies(attacker, tr, dmginfo)
   if tr.HitWorld and tr.MatType == MAT_METAL then
      local eff = EffectData()
      eff:SetOrigin(tr.HitPos)
      eff:SetNormal(tr.HitNormal)
      util.Effect("cball_bounce", eff)
   end
end

SWEP.MovementPenalty = 0.03
SWEP.ResetTime = 1
SWEP.BaseInaccuracy = 0
-- SWEP.Cone = .01

function SWEP:CalculateCone()
	local cone
	local resettime = self:GetResetTime() 
	if !self.lastBulletFiredTime or self.lastBulletFiredTime + resettime < CurTime() then
		cone = 0
	else
		self.ConsecBullets = self.ConsecBullets or 0
		local normalcone = (self:GetPrimaryCone())
		local consecbullets = self.ConsecBullets or 0
		cone =  normalcone * math.min(consecbullets*5,1) * (1 - (CurTime() - self.lastBulletFiredTime)/resettime)
	end
	local movement = self.Owner:GetVelocity():Length()
	cone = cone + (movement/(255))*(self.MovementPenalty)
	cone = cone + (self.BaseInaccuracy)
	return cone
end
function SWEP:GetResetTime() 
	return self.ResetTime + (self.Primary.Delay or 0) or 1
end

SHOWACCDATA = CreateClientConVar("showaccuracy",0,true,false)
function SWEP:ShootBullet( dmg, recoil, numbul )

	self:SendWeaponAnim(self.PrimaryAnim)

	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if not IsFirstTimePredicted() then return end

	local sights = self:GetIronsights()
	numbul = numbul or 1
	cone = self:CalculateCone()
	if CLIENT and SHOWACCDATA:GetBool() then
		hook.Add("HUDPaint","hudaccuracy",function()
			draw.SimpleText(tostring(math.ceil(cone*10000)), "HealthAmmo", ScrW()/2, (15*ScrH())/35, Color(255,255-(cone*10)*255,255-(cone*10)*255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		timer.Create("closehudaccuracy",2,0,function()
			hook.Remove("HUDPaint","hudaccuracy")
		end)
	end
	local bullet = {}
	bullet.Num    = numbul
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector( cone, cone, 0 )
	bullet.Tracer = self.Traceramt or 4
	bullet.TracerName = self.Tracer or "Tracer"
	bullet.Force  = 15
	bullet.Damage = dmg
	if CLIENT and sparkle:GetBool() then
	  bullet.Callback = Sparklies
	end

	if !self.lastBulletFiredTime or self.lastBulletFiredTime + self:GetResetTime() < CurTime() then
		self.ConsecBullets = 0
	else
		-- self.ConsecBullets = self.ConsecBullets or 0
		-- cone = (1 - (CurTime() - self.lastBulletFiredTime)/resettime)*(self:GetPrimaryCone() or 0.01) * math.min(((self.ConsecBullets or 0)/2),1)
		self.ConsecBullets = self.ConsecBullets + (CurTime() - self.lastBulletFiredTime)
	end
	self.lastBulletFiredTime = CurTime()
	
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
function SWEP:BaseCone()
	return self.Cone or self.Primary.Cone or .02
end
function SWEP:GetPrimaryCone()
   local cone = self:BaseCone()
   -- 10% accuracy bonus when sighting
   cone = self:GetIronsights() and (cone * 0.9) or cone
   return self.Owner and self.Owner:Crouching() and cone * .7 or cone
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   return self.HeadshotMultiplier
end

function SWEP:IsEquipment()
   return WEPS.IsEquipment(self)
end

function SWEP:DrawWeaponSelection() end

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) then return end
   --if self:GetNextSecondaryFire() > CurTime() then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:Deploy()
   self:SetIronsights(false)
   return true
end

function SWEP:Reload()
	if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
   self:DefaultReload(self.ReloadAnim)
   self:SetIronsights( false )
end


function SWEP:OnRestore()
   self.NextSecondaryAttack = 0
   self:SetIronsights( false )
end

function SWEP:Ammo1()
   return IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) or false
end

-- The OnDrop() hook is useless for this as it happens AFTER the drop. OwnerChange
-- does not occur when a drop happens for some reason. Hence this thing.
function SWEP:PreDrop()
   if SERVER and IsValid(self.Owner) and self.Primary.Ammo != "none" then
      local ammo = self:Ammo1()

      -- Do not drop ammo if we have another gun that uses this type
      for _, w in pairs(self.Owner:GetWeapons()) do
         if IsValid(w) and w != self and w:GetPrimaryAmmoType() == self:GetPrimaryAmmoType() then
            ammo = 0
         end
      end

      self.StoredAmmo = ammo

      if ammo > 0 then
         self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
      end
   end
end

function SWEP:DampenDrop()
   -- For some reason gmod drops guns on death at a speed of 400 units, which
   -- catapults them away from the body. Here we want people to actually be able
   -- to find a given corpse's weapon, so we override the velocity here and call
   -- this when dropping guns on death.
   local phys = self:GetPhysicsObject()
   if IsValid(phys) then
      phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
      phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
   end
end

local SF_WEAPON_START_CONSTRAINED = 1

-- Picked up by player. Transfer of stored ammo and such.
function SWEP:Equip(newowner)
   if SERVER then
      if self:IsOnFire() then
         self:Extinguish()
      end

      self.fingerprints = self.fingerprints or {}

      if not table.HasValue(self.fingerprints, newowner) then
         table.insert(self.fingerprints, newowner)
      end

      if self:HasSpawnFlags(SF_WEAPON_START_CONSTRAINED) then
         -- If this weapon started constrained, unset that spawnflag, or the
         -- weapon will be re-constrained and float
         local flags = self:GetSpawnFlags()
         local newflags = bit.band(flags, bit.bnot(SF_WEAPON_START_CONSTRAINED))
         self:SetKeyValue("spawnflags", newflags)
      end
   end

   if SERVER and IsValid(newowner) and self.StoredAmmo > 0 and self.Primary.Ammo != "none" then
      local ammo = newowner:GetAmmoCount(self.Primary.Ammo)
      local given = math.min(self.StoredAmmo, self.Primary.ClipMax - ammo)

      newowner:GiveAmmo( given, self.Primary.Ammo)
      self.StoredAmmo = 0
   end
end


-- We were bought as special equipment, some weapons will want to do something
-- extra for their buyer
function SWEP:WasBought(buyer)
end

-- Dummy functions that will be replaced when SetupDataTables runs. These are
-- here for when that does not happen (due to e.g. stacking base classes)
function SWEP:GetIronsights() return false end
function SWEP:SetIronsights() end

-- Set up ironsights dt bool. Weapons using their own DT vars will have to make
-- sure they call this.
function SWEP:SetupDataTables()
   -- Put it in the last slot, least likely to interfere with derived weapon's
   -- own stuff.
   self:NetworkVar("Bool", 3, "Ironsights")
end

function SWEP:Initialize()
   if CLIENT and self:Clip1() == -1 then
      self:SetClip1(self.Primary.DefaultClip)
   elseif SERVER then
      self.fingerprints = {}

      self:SetIronsights(false)
   end

   self:SetDeploySpeed(self.DeploySpeed)

   -- compat for gmod update
   if self.SetWeaponHoldType then
      self:SetWeaponHoldType(self.HoldType or "pistol")
   end
end

function SWEP:Think()
end

function SWEP:DyingShot()
   local fired = false
   if self:GetIronsights() then
      self:SetIronsights(false)

      if self:GetNextPrimaryFire() > CurTime() then
         return fired
      end

      -- Owner should still be alive here
      if IsValid(self.Owner) then
         local punch = self.Primary.Recoil or 5

         -- Punch view to disorient aim before firing dying shot
         local eyeang = self.Owner:EyeAngles()
         eyeang.pitch = eyeang.pitch - math.Rand(-punch, punch)
         eyeang.yaw = eyeang.yaw - math.Rand(-punch, punch)
         self.Owner:SetEyeAngles( eyeang )

         MsgN(self.Owner:Nick() .. " fired his DYING SHOT")

         self.Owner.dying_wep = self

         self:PrimaryAttack(true)

         fired = true
      end
   end

   return fired
end

local ttt_lowered = CreateConVar("ttt_ironsights_lowered", "1", FCVAR_ARCHIVE)

local LOWER_POS = Vector(0, 0, -2)

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition( pos, ang )
   if not self.IronSightsPos then return pos, ang end

   local bIron = self:GetIronsights()

   if bIron != self.bLastIron then
      self.bLastIron = bIron
      self.fIronTime = CurTime()

      if bIron then
         self.SwayScale = 0.3
         self.BobScale = 0.1
      else
         self.SwayScale = 1.0
         self.BobScale = 1.0
      end

   end

   local fIronTime = self.fIronTime or 0
   if (not bIron) and fIronTime < CurTime() - IRONSIGHT_TIME then
      return pos, ang
   end

   local mul = 1.0

   if fIronTime > CurTime() - IRONSIGHT_TIME then

      mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )

      if not bIron then mul = 1 - mul end
   end

   local offset = self.IronSightsPos + (ttt_lowered:GetBool() and LOWER_POS or vector_origin)

   if self.IronSightsAng then
      ang = ang * 1
      ang:RotateAroundAxis( ang:Right(),    self.IronSightsAng.x * mul )
      ang:RotateAroundAxis( ang:Up(),       self.IronSightsAng.y * mul )
      ang:RotateAroundAxis( ang:Forward(),  self.IronSightsAng.z * mul )
   end

   pos = pos + offset.x * ang:Right() * mul
   pos = pos + offset.y * ang:Forward() * mul
   pos = pos + offset.z * ang:Up() * mul

   return pos, ang
end

local stcolor = Color(200,100,0)
local mod
local function getstcolor()
	return mod and Color(mod*200,mod*100,255-mod*255) or stcolor
end
local function padd0(num,noerrs)
	if !noerrs and num > 999999 then return os.time()%2 == 0 and "0ERROR" or "1M+000" end
	return string.rep("0",6-string.len(num))..num
end

if TESTINGSTRANGES then
		local lastmod
	function SWEP:PostDrawViewModel(vm)
		LocalPlayer().curStrangeKills = math.floor(CurTime()/5)
		if lastmod ~= LocalPlayer().curStrangeKills then
			mod = 0
			local timerseconds = .5
			timer.Create("spookystattrackglow",.03,timerseconds*30,function()
				mod = mod + 1/(timerseconds*30)
				if mod > .98 then
					mod = nil
					timer.Destroy("spookystattrackglow")
				end
			end)
		end
		lastmod = LocalPlayer().curStrangeKills
		LocalPlayer().curStrangeKillsPadded = padd0(LocalPlayer().curStrangeKills)
		LocalPlayer().curStrangeKillsRaw = padd0(LocalPlayer().curStrangeKills,true)
		
		if self.ShowViewModel == false then
			render.SetBlend(1)
		end

		if not self.HUD3DPos or GAMEMODE.WeaponHUDMode == 1 then return end

		local pos, ang = self:GetHUD3DPos(vm)
		if pos then
			self:Draw3DHUD(vm, pos, ang)
		end
	end
	SWEP.HUD3DBone = "base"
	SWEP.HUD3DPos = Vector(-1, 0, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	function SWEP:GetHUD3DPos(vm)
		local bone = vm:LookupBone(self.HUD3DBone)
		if not bone then return end

		local m = vm:GetBoneMatrix(bone)
		if not m then return end

		local pos, ang = m:GetTranslation(), m:GetAngles()

		if self.ViewModelFlip then
			ang.r = -ang.r
		end

		local offset = self.HUD3DPos
		local aoffset = self.HUD3DAng

		pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z

		if aoffset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), aoffset.yaw) end
		if aoffset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), aoffset.pitch) end
		if aoffset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), aoffset.roll) end

		return pos, ang
	end


	function SWEP:Draw3DHUD(vm, pos, ang)
		if !LocalPlayer().curStrangeKillsPadded then return end
		local wid, hei = 180, 200
		local x, y = wid * -0.6, hei * -0.5
		local clip = self:Clip1()
		local spare = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
		local maxclip = self.Primary.ClipSize

		cam.Start3D2D(pos, ang, self.HUD3DScale/2)
			//draw.RoundedBox(32, x, y, wid, hei, Color(0,0,0,100))
			-- GetAmmoColor(clip, maxclip)
			
			draw.SimpleText(LocalPlayer().curStrangeKillsPadded, "StrangeCounter", x + wid * 0.5, y + hei * (0.5), getstcolor(), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		
	end
else
	local lastmod
	function SWEP:PostDrawViewModel(vm)
		LocalPlayer().curStrangeKillsRaw = nil
		if !LocalPlayer():GetNWBool("killson"..self:GetClass()) then return end
		LocalPlayer().curStrangeKills = math.floor(LocalPlayer():GetNWInt("kills"..self:GetClass()))
		if lastmod ~= LocalPlayer().curStrangeKills then
			mod = 0
			local timerseconds = .5
			timer.Create("spookystattrackglow",.03,timerseconds*30,function()
				mod = mod + 1/(timerseconds*30)
				if mod > .98 then
					mod = nil
					timer.Destroy("spookystattrackglow")
				end
			end)
		end
		lastmod = LocalPlayer().curStrangeKills
		LocalPlayer().curStrangeKillsPadded = padd0(LocalPlayer().curStrangeKills)
		LocalPlayer().curStrangeKillsRaw = padd0(LocalPlayer().curStrangeKills,true)
		
		if self.ShowViewModel == false then
			render.SetBlend(1)
		end

		if not self.HUD3DPos or GAMEMODE.WeaponHUDMode == 1 then return end

		local pos, ang = self:GetHUD3DPos(vm)
		if pos then
			self:Draw3DHUD(vm, pos, ang)
		end
	end
	SWEP.HUD3DBone = "base"
	SWEP.HUD3DPos = Vector(-1, 0, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	function SWEP:GetHUD3DPos(vm)
		local bone = vm:LookupBone(self.HUD3DBone)
		if not bone then return end

		local m = vm:GetBoneMatrix(bone)
		if not m then return end

		local pos, ang = m:GetTranslation(), m:GetAngles()

		if self.ViewModelFlip then
			ang.r = -ang.r
		end

		local offset = self.HUD3DPos
		local aoffset = self.HUD3DAng

		pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z

		if aoffset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), aoffset.yaw) end
		if aoffset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), aoffset.pitch) end
		if aoffset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), aoffset.roll) end

		return pos, ang
	end


	function SWEP:Draw3DHUD(vm, pos, ang)
		if !LocalPlayer().curStrangeKillsPadded then return end
		local wid, hei = 180, 200
		local x, y = wid * -0.6, hei * -0.5
		local clip = self:Clip1()
		local spare = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
		local maxclip = self.Primary.ClipSize

		cam.Start3D2D(pos, ang, self.HUD3DScale/2)
			//draw.RoundedBox(32, x, y, wid, hei, Color(0,0,0,100))
			-- GetAmmoColor(clip, maxclip)
			
			draw.SimpleText(LocalPlayer().curStrangeKillsPadded, "StrangeCounter", x + wid * 0.5, y + hei * (0.5), getstcolor(), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		
	end
end