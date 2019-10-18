////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_scryslot8
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

void main()
{
  int n=0;
  object oPC=GetPCSpeaker();
  object oTarg;
  oTarg=GetLocalObject(oPC,"scrytarg7");
  if(GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oPC)) Scrying(oPC,oTarg);
  else SendMessageToPC(oPC,"You must cast Clairvoyance on yourself first.");
}
