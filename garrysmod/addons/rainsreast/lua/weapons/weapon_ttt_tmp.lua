AddCSLuaFile()

SWEP.HoldType			= "smg"

if CLIENT then
   SWEP.PrintName			= "Silenced TMP"
   SWEP.Slot				= 6

   SWEP.Icon = "vgui/ttt/icon_tmper"
end

SWEP.EquipMenuData = {
   type = "Weapon",
   desc = [[Fires fast and kills quick. Silently.]]
};
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.Kind = WEAPON_EQUIP1

SWEP.Primary.Delay			= 0.07001166861
SWEP.Primary.Recoil			= 3.2
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Damage = 12
SWEP.Primary.Cone = 0.08
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.MovementPenalty = 0.02
SWEP.ResetTime = 1.6
SWEP.BaseInaccuracy = 0

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_tmp.mdl"

SWEP.Primary.Sound = Sound( "Weapon_TMP.Single" )

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos = Vector(-6.3, 0, 3)
SWEP.IronSightsAng = Vector(0, 0, 6)


-- We were bought as special equipment, and we have an extra to give
function SWEP:WasBought(buyer)
   if IsValid(buyer) then -- probably already self.Owner
      buyer:GiveAmmo( 20, "Pistol" )
   end
end

