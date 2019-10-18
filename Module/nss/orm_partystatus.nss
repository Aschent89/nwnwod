////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_partystatus
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "NW_I0_GENERIC"

int IsSick(object oPC)
{
  int status=FALSE;
  if(GetHasEffect(EFFECT_TYPE_ABILITY_DECREASE,oPC) ||
    GetHasEffect(EFFECT_TYPE_AC_DECREASE,oPC)||
    GetHasEffect(EFFECT_TYPE_BLINDNESS,oPC)  ||
    GetHasEffect(EFFECT_TYPE_CURSE,oPC)  ||
    GetHasEffect(EFFECT_TYPE_DAMAGE_DECREASE,oPC)  ||
    GetHasEffect(EFFECT_TYPE_DISEASE,oPC)  ||
    GetHasEffect(EFFECT_TYPE_PETRIFY,oPC)    ||
    GetHasEffect(EFFECT_TYPE_POISON,oPC)  ||
    GetHasEffect(EFFECT_TYPE_NEGATIVELEVEL))
    status=TRUE;

    return status;
}

int StartingConditional()
{
  string partystatus;
  object oPC=GetPCSpeaker();

  if(!GetLocalInt(oPC,"plminset"))
  {
    SetLocalInt(oPC,"plmin",0);
    SetLocalInt(oPC,"plminset",TRUE);
  }
  if(!GetLocalInt(oPC,"ORM_SPEEDSET"))
  {
    SetLocalInt(oPC,"ORM_SPEEDSET",TRUE);
    SetLocalFloat(oPC,"ORM_SPEED",1.0);
  }

  SetCustomToken(6664,FloatToString(GetLocalFloat(oPC,"ORM_SPEED")));
  SetCustomToken(6665,IntToString(GetLocalInt(oPC,"plmin")));

  object nPC= GetFirstFactionMember(oPC,TRUE);
  while(nPC!=OBJECT_INVALID)
  {
    if(IsSick(nPC)) partystatus=partystatus+GetName(nPC)+" doesn't look well."+"\n";
    else partystatus=partystatus+GetName(nPC)+" doesn't have any ailments."+"\n";

    nPC=GetNextFactionMember(oPC,TRUE);
  }

  SetCustomToken(6669,partystatus);

  return TRUE;
}
