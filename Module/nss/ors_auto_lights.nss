////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Turn Lights On/Off
//  ors_auto_lights
//  By:Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////


void main()
{
    object oSelf = OBJECT_SELF;

    int nELight = GetLocalInt(oSelf,"ORS_VFX");
    if(nELight < 1) nELight == VFX_DUR_LIGHT_YELLOW_20;//160

    if (GetLocalInt(OBJECT_SELF,"NW_L_AMION") == 0)
    {
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
      DelayCommand(0.4,SetPlaceableIllumination(oSelf, TRUE));
      SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
      DelayCommand(0.5,RecomputeStaticLighting(GetArea(oSelf)));
      effect eLight = EffectVisualEffect(nELight);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oSelf);
    }
    else
    {
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
}
