////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Stow the Ioun Stone
//  ors_stow_ioun
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is called from the ORM to Stow any Active Ioun Stones
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();

  effect eEffect;

  eEffect = GetFirstEffect(OBJECT_SELF);
  while (GetIsEffectValid(eEffect) == TRUE)
  {
    if(GetEffectSpellId(eEffect) > 553 && GetEffectSpellId(eEffect) < 561)
    {
      RemoveEffect(OBJECT_SELF, eEffect);
    }
    eEffect = GetNextEffect(OBJECT_SELF);
  }
}
