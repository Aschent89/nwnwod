#include "f_vampire_h"

void Vampire_Client_Enter(object oPC)
{
object oO;
location lL;
Vampire_Read_Int(oPC, "FALLEN_SUBRACE");
Vampire_Equipment_Removal(oPC, FALSE); //make sure noone comes in with hacked items from the outside...
if(GetIsVampire(oPC))
    {
    Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_LEVEL");
    Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID");
    Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES");
    Vampire_Read_Location(oPC, "FALLEN_VAMPIRE_MARK");
    DeleteLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN");
    ExecuteScript("f_vampire_oearea", oPC);
    DelayCommand(1.0, Vampire_Equipment_Creation(oPC));
    if(UseBloodNeedSystem)
        { //resume your hunger...
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM");
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER");
        if(GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM") == 0) DelayCommand(HoursToSeconds(1), Vampire_Penalty_Expired(oPC));
            else  DelayCommand(HoursToSeconds(1), Vampire_Delay_Expired(oPC));
        }

    if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_VALID"))
        {
        Vampire_Read_Location(oPC, "FALLEN_VAMPIRE_COFFIN_LOC");
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_COFFIN_GARLIC");
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_COFFIN_HWATER");
        Vampire_Read_Int(oPC, "FALLEN_VAMPIRE_COFFIN_ROSE");
        switch(WhatToDoWithTheCoffin)
            {
    //1. Destroy the coffin and put it in the players inventory for them to place
       //next time they enter the module.
            case 1:
                CreateItemOnObject("yourcoffin", oPC);
                DeleteLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN");
                Vampire_Delete_Location(oPC, "FALLEN_VAMPIRE_COFFIN_LOC");
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
                break;
    //2. Destroy the coffin and replace it there the next time the player enters
       //the game. The player will start at the coffin. (if they have one,
       //otherwise they will not be moved)
            case 2:
                lL = GetLocalLocation(oPC, "FALLEN_VAMPIRE_COFFIN_LOC");
                oO = CreateObject(OBJECT_TYPE_PLACEABLE, "vampirecoffin", lL);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_GARLIC")) SetLocalInt(oO, "FALLEN_VAMPIRE_GARLIC", TRUE);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_HWATER")) SetLocalInt(oO, "FALLEN_VAMPIRE_HOLYWATER", TRUE);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_ROSE"))
                    {
                    SetLocalInt(oO, "FALLEN_VAMPIRE_ROSEWARD", TRUE);
                    DelayCommand(HoursToSeconds(2), DeleteLocalInt(oO, "FALLEN_ROSEWARD"));
                    }
                SetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN", oO);
                SetLocalObject(oO, "FALLEN_VAMPIRE_COFFIN", oPC);
                Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_COFFIN_LOC", lL);
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", TRUE);
                SetLocalLocation(oPC, "FALLEN_VAMPIRE_DESTINATION", lL);
                ExecuteScript("f_vampirebat6", oPC);
                break;
    //3. Destroy the coffin and replace it there the next time the player enters
       //the game. The player will not be moved from wherever they log into.
            case 3:
                lL = GetLocalLocation(oPC, "FALLEN_VAMPIRE_COFFIN_LOC");
                oO = CreateObject(OBJECT_TYPE_PLACEABLE, "vampirecoffin", lL);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_GARLIC")) SetLocalInt(oO, "FALLEN_VAMPIRE_GARLIC", TRUE);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_HWATER")) SetLocalInt(oO, "FALLEN_VAMPIRE_HOLYWATER", TRUE);
                if(GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_ROSE"))
                    {
                    SetLocalInt(oO, "FALLEN_VAMPIRE_ROSEWARD", TRUE);
                    DelayCommand(HoursToSeconds(2), DeleteLocalInt(oO, "FALLEN_ROSEWARD"));
                    }
                SetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN", oO);
                SetLocalObject(oO, "FALLEN_VAMPIRE_COFFIN", oPC);
                Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_COFFIN_LOC", lL);
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", TRUE);
                break;
    //4. Leave the coffin where it is, it will become unclaimed and the pc will
       //have to find a new coffin once they log back in. They will be moved to
       //the location of that coffin when they enter the game again.
            case 4:
                lL = GetLocalLocation(oPC, "FALLEN_VAMPIRE_COFFIN_LOC");
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
                SetLocalLocation(oPC, "FALLEN_VAMPIRE_DESTINATION", lL);
                ExecuteScript("f_vampirebat6", oPC);
                break;
    //5. Leave the coffin where it is, it will become unclaimed and the pc will
       //have to find a new coffin once they log back in. They will not be moved.
            case 5:
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
                break;
    //6. Destroy the coffin, they will have to find/buy another. They will not
       //be moved.
            case 6:
                Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
                break;
            }
        }
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_COFFIN_GARLIC");
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_COFFIN_HWATER");
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_COFFIN_ROSE");
    }
else if(UseSubRaceField && GetStringUpperCase(GetSubRace(oPC)) == "VAMPIRE") SetIsVampire(TRUE, oPC);
}
