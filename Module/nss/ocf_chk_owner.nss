////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_chk_owner
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sPCU = GetLocalString(oPC,"PCU");

  //Near My Bedroll
  object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
  string sBWho = GetLocalString(oBedroll,"PCU");
  if(GetIsObjectValid(oBedroll) == TRUE
    && GetDistanceBetween(oPC,oBedroll) < 3.0
    && GetObjectType(oBedroll) == OBJECT_TYPE_PLACEABLE
    && sBWho == sPCU)
  {
    return TRUE;
  }

  //Near My Tent
  object oTent = GetNearestObjectByTag("Tent",oPC,1);
  string sTWho = GetLocalString(oTent,"PCU");
  if(GetIsObjectValid(oTent) == TRUE
    && GetDistanceBetween(oPC,oTent) < 4.0
    && GetObjectType(oTent) == OBJECT_TYPE_PLACEABLE
    && sTWho == sPCU)
  {
    return TRUE;
  }

  return FALSE;
}
