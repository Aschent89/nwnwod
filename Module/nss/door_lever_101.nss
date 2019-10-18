//::///////////////////////////////////////////////
//:: Name Lock & Unlock by Lever
//:: FileName ts_lever_ou_001.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////

void main()
{
 object oDoor = GetObjectByTag("TS_LOCKED_101");
 int nOpen = GetIsOpen(oDoor);
 if(nOpen == FALSE)
 {
  ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
  ActionUnlockObject(oDoor);
  ActionOpenDoor(oDoor);
 }
 else
 {
  ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
  ActionCloseDoor(oDoor);
 }
}

//:://////////////////////////////////////////////
//:: Created By: Chettawan Senapant
//:: Created On: 07/25/02
//::///////////////////////////////////////////
