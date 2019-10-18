////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Education/Crafting System - Defaults File
//  ocr_mod_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetEnteringObject();
    object oMod     = GetModule();

    //Check Armor/Helm/Shield/Weapon for the Reality System
    object oWeapon      = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLHand       = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    object oHelm        = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);

    //Is this Active?
    int nWD = GetLocalInt(GetModule(),"WEAPONDAMAGE");
    int nAD = GetLocalInt(GetModule(),"ARMORDAMAGE");

    //Check the Main Weapon
    if(oWeapon != OBJECT_INVALID && nWD == 1)
    {
      AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }

    //Check the Off Hand/Shield
    if(oLHand != OBJECT_INVALID && nWD == 1)
    {
       AssignCommand(oPC,ActionUnequipItem(oLHand));
    }

    //Now Check the Helm
    if(oHelm != OBJECT_INVALID  && nAD == 1)
    {
      AssignCommand(oPC,ActionUnequipItem(oHelm));
    }
}
