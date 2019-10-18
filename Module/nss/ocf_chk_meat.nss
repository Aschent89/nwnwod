////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_chk_meat
//  By Don Anderson
//  dandersonru@msn.com
//
//  Checks to see if there is any Fresh Meat on PC
//
//  To add more meats follow the examples below
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC          = GetPCSpeaker();
    object oItem;
    string sFBear       = "Fresh Bear";
    string sFBeef       = "Fresh Beef";
    string sFBison      = "Fresh Bison";
    string sFChicken    = "Fresh Chicken";
    string sFPork       = "Fresh Pork";
    string sFVenison    = "Fresh Venison";
    string sFTrout      = "Fresh Trout";
    string sFBass       = "Fresh Bass";
    string sFPike       = "Fresh Pike";
    string sFCrab       = "Fresh Crab";
    string sFLobster    = "Fresh Lobster";
    string sFSalmon     = "Fresh Salmon";
    string sFTuna       = "Fresh Tuna";
    string sFLhimil     = "Fresh Lhimil";

    // Make sure the PC speaker has these items in their inventory
    if (GetIsPC(oPC))
    {
        oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
          if (GetName(oItem) == sFBear) return TRUE;
          else if (GetName(oItem) == sFBeef) return TRUE;
          else if (GetName(oItem) == sFBison) return TRUE;
          else if (GetName(oItem) == sFChicken) return TRUE;
          else if (GetName(oItem) == sFPork) return TRUE;
          else if (GetName(oItem) == sFVenison) return TRUE;
          else if (GetName(oItem) == sFTrout) return TRUE;
          else if (GetName(oItem) == sFBass) return TRUE;
          else if (GetName(oItem) == sFPike) return TRUE;
          else if (GetName(oItem) == sFCrab) return TRUE;
          else if (GetName(oItem) == sFLobster) return TRUE;
          else if (GetName(oItem) == sFSalmon) return TRUE;
          else if (GetName(oItem) == sFTuna) return TRUE;
          else if (GetName(oItem) == sFLhimil) return TRUE;
          oItem = GetNextItemInInventory(oPC);
        }
    }
    return FALSE;
}
