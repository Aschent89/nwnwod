//::///////////////////////////////////////////////
//:: FileName f_vampirecoffinh
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 10:57:07 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "FALLEN_VAMPIRE_WILDROSE");
    object oMe = OBJECT_SELF;
    int iLockTime = 2 + (GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) * 2)
                     + (GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) * 2)
                     + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, GetPCSpeaker())
                     + GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker())
                     + Random(3);
    if(!GetIsObjectValid(oItemToTake))
        {
        FloatingTextStringOnCreature("You don't have a wild rose to use!", GetPCSpeaker());
        return;
        }
    else
        {
        DestroyObject(oItemToTake);
        SetLocalInt(oMe, "FALLEN_ROSEWARD", TRUE);
        DelayCommand(HoursToSeconds(iLockTime), DeleteLocalInt(oMe, "FALLEN_ROSEWARD"));
        }
}
