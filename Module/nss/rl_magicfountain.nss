void main()
  {
  object oPlayer=GetLastUsedBy();

  string name=GetName(oPlayer);

  string output;

  int random=d6();

  effect eHaste=EffectHaste();
  effect ePolymorph=EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
  effect eConfused=EffectConfused();
  effect eBlind=EffectBlindness();
  effect eFear=EffectFrightened();
  if (random==1)
    {
    output=name + " speeds up!";
    SpeakString(output);
    ActionCastFakeSpellAtObject(SPELL_HASTE, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHaste, oPlayer, 30.0);
    }
  if (random==2)
    {
    output=name + " feels different!";
    SpeakString(output);
    ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePolymorph, oPlayer, 40.0);

    }
  if (random==3)
    {
    output=name + " is disorientated!";
    SpeakString(output);
    ActionCastFakeSpellAtObject(SPELL_DAZE, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConfused,oPlayer,10.0);
    }
  if (random==4)
    {
    output=name + " feels better!";
    SpeakString(output);
    ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, oPlayer, METAMAGIC_ANY, TRUE);
    }
  if (random==5)
    {
    output=name + " is blinded!";
    SpeakString(output);
    ActionCastFakeSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPlayer, 20.0);
    }
  if (random==6)
    {
    output=name + " is scared!";
    SpeakString(output);
    ActionCastFakeSpellAtObject(SPELL_SCARE, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oPlayer, 25.0);
  }
}

