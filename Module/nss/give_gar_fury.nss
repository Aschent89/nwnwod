//::///////////////////////////////////////////////
//:: FileName give_gar_fury
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/15/2009 12:48:36 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
    // Give the speaker the items
CreateItemOnObject("garoucrinosshift", oPC);
CreateItemOnObject("garouglabroshift", oPC);
CreateItemOnObject("garouhisposhift", oPC);
CreateItemOnObject("garoulupisshift", oPC);
CreateItemOnObject("gar_tri_furies", oPC);

}
