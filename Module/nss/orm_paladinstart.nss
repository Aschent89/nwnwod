////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_paladinstart
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

void main()
{
  object oPC=GetPCSpeaker();
  string message="";
  location lTarget=GetLocation(oPC);

  if(GetLocalInt(oPC,"deused")!=TRUE) SetLocalInt(oPC,"deuses",4);
  if(GetLocalInt(oPC,"deuses")>1)
  {
    SetLocalInt(oPC,"deused",TRUE);
    SetLocalInt(oPC,"deuses",GetLocalInt(oPC,"deuses")-1);
    if( GetLocalInt(oPC,"deuses")==0) DelayCommand(1800.0,SetLocalInt(oPC,"deuses",4));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,15.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (oTarget!=OBJECT_INVALID)
    {
      if(GetAlignmentGoodEvil(oTarget)==ALIGNMENT_EVIL) message+="You sense that "+GetName(oTarget)+" is evil.\n";
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, 15.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    if(message=="") message="You do not detect the presence of evil nearby.";
  }
  else message="You may not use your ability for awhile.";

  SetCustomToken(8200,message);
}
