#include "x2_inc_switches"
#include "f_vampirespell_h"
//****************************************************************8
#include "x2_inc_switches"
#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_craft"
#include "wdm_inc"
//#include "oai_inc_weapstat"
#include "f_vampirespell_h"
#include "q_stackable_inc"

void main()
{
object oCaster = OBJECT_SELF;
//object oCaster = oPC;
//object oWitchunterArea = GetArea(oCaster);


//Vampire SUbrace check
string sRace= GetSubRace(OBJECT_SELF);
 object oItem;
 int nCheck;
 string sResRef;

// The Variable "DW_WITCHUNTER_AREA" needs to be set to 1 on every area you want
//the Witchunters to monitor. You can change this variable name below if you wish.
//int nWHTrue = GetLocalInt (oWitchunterArea, "DW_WITCHUNTER_AREA");

//Checks Go Here.

//Checks to see if the spell was cast from an item (ie a potion) if so the
//Witchunters ignore it.
if (!(GetSpellCastItem() == OBJECT_INVALID))
return;

//Checks to see if the Spellcaster has the "Empire Wizard's Amulet".
//If so, nothing will happen to them. Change the string "EMPIREWIZARD"
//below to match the tag of the item you want to use, or alternatively
//copy and paste the two lines below, changing the "EMPIREWIZARD" string
//to create as many exemption items as you like.

//Checks to see if the Caster is a Paladin - if so the Witchunters ignore him.
if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
return;

//Checks to see if the Caster is a Ranger - if so the Witchunters ignore him.
if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
return;
//Effects go here.

/*if (nWHTrue == 1)

    {
    object oTarget = oCaster;
    location lTarget = GetLocation(oTarget);
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "witchunter", lTarget);
    SendMessageToPC(oTarget, "Your use of magic has been noticed!!");
    oTarget = oSpawn;

    //Starts the conversation "dw_witchunter" between the Spellcaster and the
    //newly spawned in Witchunter. Again, you can change the conversation to a
    //different one by altering the string below.
    DelayCommand(3.0, AssignCommand(oTarget, ActionStartConversation(oCaster, "dw_witchunter")));

    oTarget = oSpawn;
    //Thank you LilacSoul for the bit below! It applies the Unsummon VFX accurately.
    int nInt;
    nInt = GetObjectType(oTarget);
    if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget));
    else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget)));
    }
 */

 if(sRace == "Vampire")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "FALLEN_VAMPIRE_GOOD_BLOOD");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the blood to use that power.");
  }
  else//else they DO HAVE a valid object
  {

  ActionTakeStackedItemsByTag("FALLEN_VAMPIRE_GOOD_BLOOD",oCaster,1);
   }
  }


 if(sRace == "Mage")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "mage_vis");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the Vis to use that power.");
  }
  else//else they DO HAVE a valid object
  {
ActionTakeStackedItemsByTag("mage_vis",oCaster,1);
   }
  }

 if(sRace == "Garou_Homid")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "wyld_energy");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the Spiritual to do that.");
  }
  else//else they DO HAVE a valid object
  {
ActionTakeStackedItemsByTag("wyld_energy",oCaster,1);
   }
  }
 if(sRace == "Garou_Lupis")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "wyld_energy");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the Spiritual to do that.");
  }
  else//else they DO HAVE a valid object
  {
ActionTakeStackedItemsByTag("wyld_energy",oCaster,1);
   }
  }
 if(sRace == "Garou_Metis")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "wyld_energy");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the Spiritual to do that.");
  }
  else//else they DO HAVE a valid object
  {
ActionTakeStackedItemsByTag("wyld_energy",oCaster,1);
   }
  }

  int iSpell = GetSpellId(); //this is the same as GetLastSpell isn't it?
switch(iSpell)
    {
    case SPELL_LESSER_RESTORATION: nw_s0_lsrestor(); break;
    case SPELL_RESTORATION: nw_s0_restore(); break;
    case SPELL_GREATER_RESTORATION: nw_s0_grrestore(); break;
    case SPELL_HEAL: nw_s0_heal(); break;
    case SPELL_MASS_HEAL: nw_s0_masheal(); break;
    case SPELL_HEALING_CIRCLE: nw_s0_healcirc(); break;
    case SPELL_NEGATIVE_ENERGY_BURST: nw_s0_negburst(); break;
    case SPELL_NEGATIVE_ENERGY_RAY: nw_s0_negray(); break;
    //case SPELLABILITY_PULSE_NEGATIVE: break; //spell abilities do not use the hooks
    //case SPELLABILITY_DRAGON_BREATH_NEGATIVE: break; //spell abilities do not use the hooks
    case SPELL_CURE_CRITICAL_WOUNDS: nw_s0_curcrwn(); break;
    case SPELL_CURE_LIGHT_WOUNDS: nw_s0_curlgtw(); break;
    case SPELL_CURE_MINOR_WOUNDS: nw_s0_curminw(); break;
    case SPELL_CURE_MODERATE_WOUNDS: nw_s0_curmodw(); break;
    case SPELL_CURE_SERIOUS_WOUNDS: nw_s0_curserw(); break;
    case 431: case 432: case 609: case 433: case 610:
    case 434: case 611: case 435: case 612: x0_s0_inflict(); break;
    case SPELL_HARM: nw_s0_harm(); break;
    case SPELL_CIRCLE_OF_DOOM: nw_s0_circdoom(); break;
    case SPELL_HORRID_WILTING: nw_s0_horrwilt(); break;
    case SPELL_SEARING_LIGHT: nw_s0_searlght(); break;
    case SPELL_SUNBEAM: nw_s0_sunbeam(); break;
    case SPELL_SUNBURST: x0_s0_sunburst(); break;
    case SPELL_VAMPIRIC_TOUCH: nw_s0_vamptch(); break;
    //case SPELLABILITY_PULSE_HOLY: break; //spell abilities do not use the hooks
    //case SPELLABILITY_TURN_UNDEAD: break; //spell abilities do not use the hooks
    case SPELL_STONE_BONES: x2_s0_stnbones(); break;
    case SPELL_UNDEATH_TO_DEATH: x2_s0_undeath(); break;
    case SPELL_HEALING_STING: x2_s0_healstng(); break;
    case SPELL_DROWN: x0_s0_drown(); break;
    default: return;
    }


//debug//SendMessageToPC(GetFirstPC(), "Casting altered: " + IntToString(iSpell));
SetModuleOverrideSpellScriptFinished();


}

