////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Underwater System
//  ouw_area_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Area On Enter Underwater Script
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_spells"

void main()
{
    object oPC = GetEnteringObject();

    //Underwater Defined Area
    object oUWWP = GetNearestObjectByTag("Underwater",oPC);
    if(!GetIsObjectValid(oUWWP))
    {
      //Destroy Old Underwater Item
      object oUW = GetItemPossessedBy(oPC,"UnderWater");
      if(GetIsObjectValid(oUW))
      {
        object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
        AssignCommand(oPC,ActionUnequipItem(oArmor));
        AssignCommand(oPC,ActionEquipItem(oArmor,INVENTORY_SLOT_CHEST));
        DestroyObject(oUW);
      }
      return;
    }

    if(GetIsPC(oPC))
    {
      SetLocalInt(oPC,"AIRPOCKET",FALSE);

      //Destroy Old Underwater Item
      object oUW = GetItemPossessedBy(oPC,"UnderWater");
      if(GetIsObjectValid(oUW)) DestroyObject(oUW);

      //Now Make a New Underwater Item
      oUW = CreateItemOnObject("underwater",oPC);

      //Now Figure out How Many Rounds a Player Can Breath
      int nRounds = 10;
      int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
      if(nCON > 4) nCON = 4;//Remove supernatural abilities
      int nTotal = nRounds - nCON;

      //Set Rounds to Underwater Item
      SetLocalInt(oUW,"UNDERWATER_TOT_ROUNDS",nTotal);
      SetLocalInt(oUW,"UNDERWATER_CUR_ROUNDS",nTotal);

      //Remove and Add Speed Decreases
      RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);
      effect eArmorpen = SupernaturalEffect(EffectMovementSpeedDecrease(30));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eArmorpen, oPC);

      ExecuteScript("ouw_main",oPC);
    }
}
