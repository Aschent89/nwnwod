void main()
{
  object oPC = GetLastPlayerDied();
if (GetItemPossessedBy(oPC, "soulrune")!= OBJECT_INVALID)
   {
      object oKiller = GetLastHostileActor (oPC);
      object oWeapon = GetLastWeaponUsed (oKiller);
      int iChances = d10();

    if (GetItemPossessedBy(oKiller, "vorpalmarker")!= OBJECT_INVALID)
       {


        if (iChances == 1)
              {



                object oTarget;
                CreateItemOnObject ("permadead",oPC);
                location lTarget;
                oTarget = GetWaypointByTag("permadead");
                lTarget = GetLocation(oTarget);
                if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionJumpToLocation(lTarget));

               }
       }
   }

else if (GetItemPossessedBy(oPC, "fallenfangs")!= OBJECT_INVALID)
   {
      object oKiller = GetLastHostileActor (oPC);
      object oWeapon = GetLastWeaponUsed (oKiller);
      int iChances = d4();

    if (GetItemPossessedBy(oKiller, "vorpalmarker")!= OBJECT_INVALID)
       {


        if (iChances == 1)
              {



                object oTarget;
                CreateItemOnObject ("permadead",oPC);
                location lTarget;
                oTarget = GetWaypointByTag("permadead");
                lTarget = GetLocation(oTarget);
                if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionJumpToLocation(lTarget));

               }
       }
   }


}
