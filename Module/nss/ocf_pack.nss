////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_pack
//  by Don Anderson
//  dandersonru@msn.com
//
//  Packs the Tent or Bedroll (From Resting Menu)
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  string sPCU = GetLocalString(oPC,"PCU");

  string sResRef;
  location lTarget;

  //Near My Bedroll
  object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
  string sBWho = GetLocalString(oBedroll,"PCU");
  if(GetIsObjectValid(oBedroll) == TRUE
    && GetDistanceBetween(oPC,oBedroll) < 3.0
    && GetObjectType(oBedroll) == OBJECT_TYPE_PLACEABLE
    && sBWho == sPCU)
  {
    sResRef = GetLocalString(oBedroll,"RESREF");
    lTarget = GetLocation(oBedroll);
    DestroyObject(oBedroll,2.0);
    SetLocalInt(oPC,"REST_ALLOWED",FALSE);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionMoveToLocation(lTarget));
    DelayCommand(1.5, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0)));
    CreateItemOnObject(sResRef, oPC);
    return;
  }

  //Near My Tent
  object oTent = GetNearestObjectByTag("Tent",oPC,1);
  string sTWho = GetLocalString(oTent,"PCU");
  if(GetIsObjectValid(oTent) == TRUE
    && GetDistanceBetween(oPC,oTent) < 4.0
    && GetObjectType(oTent) == OBJECT_TYPE_PLACEABLE
    && sTWho == sPCU)
  {
    sResRef = GetLocalString(oTent,"RESREF");
    lTarget = GetLocation(oTent);
    DestroyObject(oTent,2.0);
    SetLocalInt(oPC,"REST_ALLOWED",FALSE);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionMoveToLocation(lTarget));
    DelayCommand(1.5, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0)));
    CreateItemOnObject(sResRef, oPC);
    return;
  }
}
