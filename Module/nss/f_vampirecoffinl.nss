//::///////////////////////////////////////////////
//:: FileName f_vampirecoffinl
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 11:44:34 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC24");
    if(!GetIsObjectValid(oItemToTake))
        {
        FloatingTextStringOnCreature("You don't have any garlic to use!", GetPCSpeaker());
        return;
        }
    if(!GetLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN"))
        {
        FloatingTextStringOnCreature("Your too late, the vampire has awoken!", GetPCSpeaker());
        return;
        }
    DestroyObject(oItemToTake);
    // Set the variables
    SetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_GARLIC", TRUE);
}
