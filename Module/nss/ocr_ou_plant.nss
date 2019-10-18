////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Harvesting Plants
//  ocr_ou_plant
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of a tree
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC  = GetLastUsedBy();
    object oMod = GetModule();

    if(!GetIsPC(oPC)) return;

    //Plant Tag
    string sTag = GetTag(oSelf);

    //Herb ResRef
    string sResRef = GetStringLowerCase(sTag);

    //Herbal Knife Equipped
    string sWA = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    if(sWA == "HerbalKnife")
    {
      CreateItemOnObject(sResRef,oPC,d6(1));
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
      DestroyObject(oSelf,5.0);
    }
    else
    {
      SendMessageToPC(oPC, "Please equip the Herbal Knife to take the Herbs.");
      SetUseableFlag(oSelf,FALSE);
    }
}

