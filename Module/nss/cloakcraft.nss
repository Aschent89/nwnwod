#include "x2_inc_itemprop"
// ----------------------------------------------------------------------------
// x3_dm_updateclk - Cloak Updater
// Modified and renamed cloakcraft by Foy 09/20/06 for Hlontar
// Modified by Foy 09/24/2007:
//  1) Added iMinModelNum to support non-CEP modules
//  2) Copy over tag of item for tag-based scripting
//  3) Copy over the number of charges
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
/*
    Function: Replace the brown default cloak on characters aquired before
    patch 1.68 with a new colored version from the resources. Can also be used
    to craft cloaks into any appearance.

    This script allows a player to toggle through all the possible appearances
    in the CEP 168 patch and above. It assumes "base cloaks" with res refs of
    basecloak00 - basecloak29. Base cloak 00 is invisible and 28 is the
    dragon cloak with wings. Not that it really matters to this script what
    order they are in as long as there are cloaks numbered 00-28.

    Once it has acquired the base cloak, it then moves all the item properties
    from the old Cloak to the new one including the various flags and colors.

    I wish I could transfer the descriptions but I can't figure that one out.
    If anyone does please PM me (Foy) at the Bioware Neverwinter site (assuming
    it still exists when you read this).

    It will update the currently equipped cloak. Make sure to have at least
    one free space in your inventory.

    As of the 09/07 update non-CEP modules can be supported by setting the
    nMinModelNum and nMaxModelNum to 1 and 14 respectively. This means the
    invisible option is not available. It also means that the cloaks will not
    allow visible wings on winged characters.

*/

// ----------------------------------------------------------------------------
// 2006-09-05 :: Georg Zoeller. (c) BioWare Corp 2006
// ----------------------------------------------------------------------------
void _CopyProps(object oOld, object oNew)
{
    if (GetIsObjectValid(oOld) && GetIsObjectValid(oNew))
    {
        itemproperty ip = GetFirstItemProperty(oOld);
        while (GetIsItemPropertyValid(ip))
        {
            AddItemProperty(DURATION_TYPE_PERMANENT,ip,oNew);

            ip = GetNextItemProperty(oOld);
        }
    }
}

// ----------------------------------------------------------------------------
// Changes the color of an item armor
// I know IPDyeArmor does the same thing but I don't want to delete cloak until
// I know the new cloak is a valid item
// oItem        - The armor
// nColorType   - ITEM_APPR_ARMOR_COLOR_* constant
// nColor       - color from 0 to 63
// Since oItem is destroyed in the process, the function returns
// the item created with the color changed
// ----------------------------------------------------------------------------
object MyDyeArmor(object oItem, int nColorType, int nColor)
{
    object oRet = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_COLOR,nColorType,nColor,TRUE);
    if (GetIsObjectValid(oRet))
        DestroyObject(oItem);   // remove old item
    else
        oRet = oItem;           // failed, just return the original

    return oRet; //return new item
}

// ----------------------------------------------------------------------------
// Main() logic for cloak crafting
// ----------------------------------------------------------------------------
void main()
{

  object oPC = GetLastUsedBy();                             // The PC
  object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);

  // if cloak in cloak slot
  if (GetIsObjectValid(oCloak) && GetIsObjectValid(oPC))
  {
    string sResRef = GetResRef(oCloak);
    string sName = GetName(oCloak);
    string sTag = GetTag(oCloak);       // So we can set the tag on the new cloak later (Foy 09/07)
    string sNewResRef;
    int iModelNum;         // 00=invisible, 1-14 no wings, 15-28 wings
    int iColor;
    int iWingType;
    int iMaxModelNum = 28;      // to support non-CEP module set this to 14
    int iMinModelNum = 0;       // to support non-CEP module set this to 1 (Foy 09/07)

    // If we have a resref.
    if (sResRef != "")
    {

        // Comment this section out if using an item instead of a placeable
        PlaySound("as_sw_lever1");
        ActionPlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
        ActionPlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);

        // First find out if the PC has wings
        if (GetCreatureWingType(oPC) == CREATURE_WING_TYPE_NONE)
            iMaxModelNum = 14;

        // Instance the invisible IP work container
        object oContainer = IPGetIPWorkContainer();

        // Build the new ResRef
        if (GetStringLeft(sResRef,9) != "basecloak")
            sNewResRef = "basecloak0" + IntToString(iMinModelNum);  // Set to minimum model on first attempt (Foy 09/07)
        else
        {
            iModelNum = StringToInt(GetStringRight(sResRef,2)) + 1;
            if (iModelNum < iMinModelNum || iModelNum > iMaxModelNum)   // Start over if invalid
                iModelNum = iMinModelNum;                               // sNewResRef = "basecloak00"; (Foy 09/07)
            // else
            if (iModelNum < 10)
                sNewResRef = "basecloak0" + IntToString(iModelNum);
            else
                sNewResRef = "basecloak" + IntToString(iModelNum);
        }

        // Create new cloak template in invisible container
        object oNew = CreateItemOnObject (sNewResRef,oContainer);

        if (GetIsObjectValid(oNew))
        {

            SendMessageToPC(oPC,"New Appearance will be " + GetName(oNew) + "");

            // remove all permanent item properties present on the template cloak
            // Base Cloaks don't have properties but just in case...
            IPRemoveAllItemProperties(oNew,DURATION_TYPE_PERMANENT);

            // instead, add the item properties from the current cloak
            _CopyProps(oCloak,oNew);

            // sync colors from old cloak
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_LEATHER1, iColor);
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_LEATHER2, iColor);
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_CLOTH1, iColor);
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_CLOTH2, iColor);
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_METAL1, iColor);
            iColor = GetItemAppearance(oCloak, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2);
            oNew = MyDyeArmor(oNew, ITEM_APPR_ARMOR_COLOR_METAL2, iColor);

            // sync other properties
            SetName(oNew,sName);
            SetIdentified(oNew,GetIdentified(oCloak));
            SetPlotFlag(oNew,GetPlotFlag(oCloak));
            SetStolenFlag(oNew,GetStolenFlag(oCloak));
            SetItemCursedFlag(oNew,GetItemCursedFlag(oCloak));
            SetDroppableFlag(oNew,GetDroppableFlag(oCloak));
            SetItemCharges(oNew, GetItemCharges(oCloak));       // (Foy 09/07 with thanks to Mord)

            // create a copy of the new cloak on the player
            // Foy 09/07 - Change from CopyItem to copy object so we can set the tag at the same time
            // object oNewCloak = CopyItem(oNew, oPC, TRUE);
            object oNewCloak = CopyObject(oNew, GetLocation(oPC), oPC, sTag);

            // destroy the old cloak
            DestroyObject(oCloak);

            // destroy the copy template to prevent cluttingring up the item property container
            DestroyObject(oNew);

            // force player to equip new cloak.
            // Put in a pause in case the pc has wings
            // There seems to be some sort of bug where the wings disappear if you exchange too quickly
            AssignCommand(oPC,ClearAllActions(TRUE));
            DelayCommand(1.00,AssignCommand(oPC,ActionEquipItem(oNewCloak, INVENTORY_SLOT_CLOAK)));

        }
        else
        {
            SendMessageToPC(oPC,"Failed to create item with resref " + sResRef + "");
            return;
        }

    }
    else
    {
        // error message, we need a resref to update the cloak, if no resref exist, we can't do that.
        SendMessageToPC(oPC,"Could not convert " + GetName (oCloak) + ", this can only be done by the module author");
        return;
    }

  }
  else
  {
     // Inform player of no cloak present
     SendMessageToPC(oPC,"You need to equip the cloak you want to convert before running the script");
  }
}


