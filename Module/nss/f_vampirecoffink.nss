//::///////////////////////////////////////////////
//:: FileName f_vampirecoffink
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 11:44:34 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "X1_WMGRENADE005");
    if(!GetIsObjectValid(oItemToTake)) oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC15");
    if(!GetIsObjectValid(oItemToTake))
        {
        FloatingTextStringOnCreature("You don't have any holy water to use!", GetPCSpeaker());
        return;
        }
    if(!GetLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN"))
        {
        FloatingTextStringOnCreature("Your too late, the vampire has awoken!", GetPCSpeaker());
        return;
        }
    DestroyObject(oItemToTake);
    // Set the variables
    SetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_HOLYWATER", TRUE);
    FloatingTextStringOnCreature("The holy water scorches and burns the vampire, doing great damage.", GetPCSpeaker());
}
