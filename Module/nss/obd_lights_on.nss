////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_lights_on
//  By Don Anderson
//  dandersonru@msn.com
//
//  Turns the placeable object's animation on
//
////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(0.4,SetPlaceableIllumination(oSelf, TRUE));
    SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
    DelayCommand(0.5,RecomputeStaticLighting(GetArea(oSelf)));
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oSelf));
}
