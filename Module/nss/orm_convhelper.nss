////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_convhelper
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

int StartingConditional()
{
  location lTarget = GetLocation(GetPCSpeaker());
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE);

  int n=0;
  while (n<7)
  {
    if(GetIsObjectValid(oTarget))
    {
      if(GetIsObjectValid(oTarget))
      {
        SetLocalObject(GetPCSpeaker(),"targ"+IntToString(n),oTarget);
        SetCustomToken(7000+n,GetName(oTarget));
      }
      else
      {
        SetLocalString(GetPCSpeaker(),"targ"+IntToString(n),"none");
        SetCustomToken(7000+n,"[Empty] ");
      }
    }
    else
    {
      SetLocalString(GetPCSpeaker(),"targ"+IntToString(n),"none");
      SetCustomToken(7000+n,"[Empty] ");
    }
    n++;
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
  return TRUE;
}
