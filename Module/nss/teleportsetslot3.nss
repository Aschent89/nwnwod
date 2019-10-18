void main()
{
    object oPC = GetLastSpeaker();
    object oItemToTake = GetItemPossessedBy(oPC, "Rune_Stone");
    location lPC = GetLocation( oPC );
    string sTag1 = GetName( oPC ) + "_" + GetPCPublicCDKey(oPC);
    string sTag2 = "Binding3";
    string sTag3 = "Int_binding_3";
    string sMessage1 = "Binding 3 is set.";
    string sMessage2 = "You do not have a rune stone to set a binding.";
    int nAnimation1 = ANIMATION_LOOPING_CONJURE1;
    int nDuration1 = DURATION_TYPE_TEMPORARY;
    int nSpell1 = SPELL_RESURRECTION;
    float fSpeed1 = 1.0;
    float fDuration1 = 6.0;
    effect eGhost1 = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
    effect eBlue = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect eWarding = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING);
    effect eWord = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eVis5 = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eVis6 = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eVis7 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

if(GetItemPossessedBy(oPC, "Rune_Stone") == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature(sMessage2, oPC);
  return;
      }

    DestroyObject(oItemToTake);
    AssignCommand(oPC, ActionCastFakeSpellAtLocation(nSpell1, lPC));
    DelayCommand(6.0, ApplyEffectToObject(nDuration1, eGhost1, oPC, 10.0));
    DelayCommand(4.0, ApplyEffectAtLocation(nDuration1, eVis6, lPC, 6.0));
    DelayCommand(4.0, ApplyEffectAtLocation(nDuration1, eVis7, lPC, 3.0));
    DelayCommand(3.0, ApplyEffectAtLocation(nDuration1, eBlue, lPC, 6.0));
    DelayCommand(3.0, ApplyEffectAtLocation(nDuration1, eWarding, lPC, 12.0));
    DelayCommand(3.0, ApplyEffectAtLocation(nDuration1, eVis5, lPC, 6.0));
    DelayCommand(3.0, ApplyEffectAtLocation(nDuration1, eWord, lPC, 6.0));
    DelayCommand(7.0, FloatingTextStringOnCreature(sMessage1 , oPC, FALSE));
    SetCampaignLocation( sTag1, sTag2, lPC, oPC );
    SetCampaignInt( sTag1, sTag3, 1, oPC );
}
