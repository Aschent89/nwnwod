//For the onPhysicalAttacked event of a locked door
#include "nw_o0_itemmaker"

void main()
{
//Make this door resistant to piercing damage, as it should be
//Unfortunately, the first piercing attack will work (oh well!)

ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectDamageResistance(DAMAGE_TYPE_PIERCING,10)),OBJECT_SELF);

//If door is unlocked, open
if(GetLocked(OBJECT_SELF)==FALSE)
ActionOpenDoor(OBJECT_SELF);

object oBasher = GetLastAttacker();
object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oBasher);
int BashDC;

//Determine door bash DC
int nDoorHP = GetMaxHitPoints(OBJECT_SELF);
if (nDoorHP<20)
   {
   //Weak door
   BashDC = 13;
   }
else if (nDoorHP>=20 && nDoorHP<40)
   {
   //Good Door
   BashDC = 18;
   }
else if (nDoorHP>=40 && nDoorHP<60)
   {
   //Strong Door
   BashDC = 23;
   }
else if (nDoorHP>=60)
   {
   //Iron Door
   BashDC = 28;
   }


//Assign weapon break chances
int nBreakChance;
int nDamageDone;

switch(GetBaseItemType(oWeapon))
   {
   case BASE_ITEM_BASTARDSWORD:
   nBreakChance = 5;
   break;
   case BASE_ITEM_BATTLEAXE:
   nBreakChance = 1;
   break;
   case BASE_ITEM_CLUB:
   nBreakChance = 0;
   break;
   case BASE_ITEM_DAGGER:
   nBreakChance = 5;
   break;
   case BASE_ITEM_DIREMACE:
   nBreakChance = 5;
   break;
   case BASE_ITEM_DOUBLEAXE:
   nBreakChance = 1;
   break;
   case BASE_ITEM_GREATAXE:
   nBreakChance = 1;
   break;
   case BASE_ITEM_GREATSWORD:
   nBreakChance = 5;
   break;
   case BASE_ITEM_HALBERD:
   nBreakChance = 1;
   break;
   case BASE_ITEM_HANDAXE:
   nBreakChance = 1;
   break;
   case BASE_ITEM_HEAVYFLAIL:
   nBreakChance = 1;
   break;
   case BASE_ITEM_KAMA:
   nBreakChance = 5;
   break;
   case BASE_ITEM_KATANA:
   nBreakChance = 3;
   break;
   case BASE_ITEM_KUKRI:
   nBreakChance = 5;
   break;
   case BASE_ITEM_LIGHTFLAIL:
   nBreakChance = 5;
   break;
   case BASE_ITEM_LIGHTHAMMER:
   nBreakChance = 1;
   break;
   case BASE_ITEM_LIGHTMACE:
   nBreakChance = 1;
   break;
   case BASE_ITEM_LONGSWORD:
   nBreakChance = 5;
   break;
   case BASE_ITEM_MORNINGSTAR:
   nBreakChance = 5;
   break;
   case BASE_ITEM_QUARTERSTAFF:
   nBreakChance = 3;
   break;
   case BASE_ITEM_RAPIER:
   nBreakChance = 10;
   break;
   case BASE_ITEM_SCIMITAR:
   nBreakChance = 5;
   break;
   case BASE_ITEM_SCYTHE:
   nBreakChance = 5;
   break;
   case BASE_ITEM_SHORTSPEAR:
   nBreakChance = 5;
   break;
   case BASE_ITEM_SHORTSWORD:
   nBreakChance = 5;
   break;
   case BASE_ITEM_SICKLE:
   nBreakChance = 5;
   break;
   case BASE_ITEM_TWOBLADEDSWORD:
   nBreakChance = 5;
   break;
   case BASE_ITEM_WARHAMMER:
   nBreakChance = 1;
   break;
   case BASE_ITEM_DART:
   case BASE_ITEM_SLING:
   case BASE_ITEM_THROWINGAXE:
   case BASE_ITEM_SHURIKEN:
   case BASE_ITEM_SHORTBOW:
   case BASE_ITEM_LONGBOW:
   case BASE_ITEM_HEAVYCROSSBOW:
   case BASE_ITEM_LIGHTCROSSBOW:
   //Missile Weapons - half damage
   nDamageDone = GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING||DAMAGE_TYPE_PIERCING||DAMAGE_TYPE_SLASHING);
   ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nDamageDone/2),OBJECT_SELF);
   //Missile weapons will not break, and will not bash open a door
   return;
   break;
   }

//Magical weapons generally will not break
if(GetIsMagical(oWeapon))
nBreakChance = nBreakChance - 4;

//Check to bash open
int nBashCheck = d20() + GetAbilityModifier(ABILITY_STRENGTH,oBasher);
if (nBashCheck>=BashDC)
   {
   //Door has been bashed open
   SetLocked(OBJECT_SELF,FALSE);
   ActionOpenDoor(OBJECT_SELF);
   DelayCommand(60.0,ActionCloseDoor(OBJECT_SELF));
   SendMessageToPC(oBasher,"You have bashed open the door.");
   AssignCommand(oBasher,ClearAllActions());
   }

//Check to break weapon
if (d100()<=nBreakChance)
   {
   SendMessageToPC(oBasher,"You have broken your " + GetName(oWeapon) + " on the door.");
   DestroyObject(oWeapon);
   }

}
