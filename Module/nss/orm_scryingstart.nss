////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_scryingstart
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

int StartingConditional()
{
  object oPC=GetPCSpeaker();
  int nPage=GetLocalInt(oPC,"scryingpage");
  if(nPage==0)
  {
    SetLocalInt(oPC,"scryingpage",1);
    nPage=GetLocalInt(oPC,"scryingpage");
  }

  SetCustomToken(8009,IntToString(nPage));

  object oTarget;
  if(nPage==1) oTarget =GetFirstPC();

  int n=0;
  while (n<7)
  {
    int i;
    if(nPage>1) for(i=0;i<(nPage-1)*7;i++) GetNextPC();

    if(GetIsObjectValid(oTarget) && !GetIsDM(oTarget))
    {
      SetLocalObject(GetPCSpeaker(),"scrytarg"+IntToString(n),oTarget);
      SetCustomToken(8000+n,GetName(oTarget));
    }
    else
    {
      SetLocalString(GetPCSpeaker(),"scrytarg"+IntToString(n),"none");
      SetCustomToken(8000+n,"[Empty] ");
    }
    n++;
    oTarget = GetNextPC();
  }
  return TRUE;
}
