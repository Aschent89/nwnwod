////////////////////////////////////////////////////////////////////////////////
//  Teleport to Object or Waypoint
//  ors_teleport
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Door OnUsed Event
//
/*
  Secret door that takes you to a Waypoint or Object that
  is stored into the Destination local string.
  FileName x2_use_secrtdoor
  Copyright (c) 2001 Bioware Corp.
*/
//
////////////////////////////////////////////////////////////////////////////////

void SendCreature(object oCreature, object oDest)
{
  if(oCreature != OBJECT_INVALID)
  {
    AssignCommand(oCreature, ClearAllActions());
    AssignCommand(oCreature, ActionJumpToObject(oDest,FALSE));
  }
}

void main()
{
  object oidUser;
  object oidDest;
  string sDest;

  if(!GetLocked(OBJECT_SELF))
  {
    //Portals Do Not Required to be Opened
    int nPortal = FindSubString(GetName(OBJECT_SELF),"Portal");
    if(GetIsOpen(OBJECT_SELF) || nPortal != -1)
    {
      sDest = GetLocalString(OBJECT_SELF,"Destination");

      float fASD = GetLocalFloat(GetModule(),"ASD");

      oidUser = GetLastUsedBy();
      oidDest = GetObjectByTag(sDest);
      SignalEvent(oidDest, EventUserDefined(101)); // reveal the secret door on the other side
      AssignCommand(oidDest, ActionOpenDoor(oidDest));
      AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));

      object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oidUser);
      object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oidUser);
      object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oidUser);
      object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oidUser, 1);
      object oHenchman2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oidUser, 2);
      object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oidUser);

      SendCreature(oAnimal, oidDest);
      SendCreature(oDominated, oidDest);
      SendCreature(oFamiliar, oidDest);
      SendCreature(oHenchman, oidDest);
      SendCreature(oHenchman2, oidDest);
      SendCreature(oSummoned, oidDest);

      DelayCommand(fASD, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }
    else
    {
      PlayAnimation(ANIMATION_PLACEABLE_OPEN);
    }
  }
}
