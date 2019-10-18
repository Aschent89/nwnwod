 void main()
{
    object tv_1 = GetObjectByTag("wp_sabbat");
    object oPlayer = GetPCSpeaker();
    object oPC = GetPCSpeaker();
//    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);

//oTarget = GetObjectByTag("independents_key");

//DestroyObject(oTarget, 0.0);

CreateItemOnObject("sabbat_key", oPC);

    {
        DelayCommand(0.0, ActionSpeakString("Good Bye."));

        DelayCommand(0.0, ActionCastFakeSpellAtObject(SPELL_LIGHTNING_BOLT, oPlayer));

        DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPlayer, 0.5));

        DelayCommand(2.5, AssignCommand(oPlayer, JumpToObject(tv_1)));
    }
}
