////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_lights_off
//  By Don Anderson
//  dandersonru@msn.com
//
//  Turns the placeable object's animation off
//
////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    DelayCommand(0.4,SetPlaceableIllumination(oSelf, FALSE));
    SetLocalInt(OBJECT_SELF,"NW_L_AMION",0);
    DelayCommand(0.9,RecomputeStaticLighting(GetArea(oSelf)));

    effect eEffect = GetFirstEffect(oSelf);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
      if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT) RemoveEffect(oSelf, eEffect);
      eEffect = GetNextEffect(oSelf);
    }
}
