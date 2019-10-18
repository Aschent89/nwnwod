////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Sail to Object or Waypoint
//  ors_sail
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable OnUsed Event
//
//  Takes Hitpoints of Placeable as Gold from the Player
//  Set Reflex Saving Throw to:
//  Evil =>  1
//  Good =>  2
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
  object oBell = OBJECT_SELF;
  object oPC = GetLastUsedBy();
  object oidDest;
  string sDest;

  int nPrice = GetMaxHitPoints(oBell);
  int nGold = GetGold(oPC);
  if(nGold >= nPrice)
  {
    TakeGoldFromCreature(nPrice,oPC,TRUE);

    sDest = GetLocalString(OBJECT_SELF,"Destination");
    oidDest = GetObjectByTag(sDest);
    AssignCommand(oPC,ActionJumpToObject(oidDest,FALSE));

    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);

    SendCreature(oAnimal, oidDest);
    SendCreature(oDominated, oidDest);
    SendCreature(oFamiliar, oidDest);
    SendCreature(oSummoned, oidDest);
  }
}
