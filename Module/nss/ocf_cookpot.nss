////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_cookpot
//  By Don Anderson
//  dandersonru@msn.com
//
//  Sets up Campfire with a Cook Pot
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    //Destroys Campfire and Sets up Cook Pot
    object oCampfire = GetNearestObjectByTag("Campfire");
    int nLC = GetLocalInt(oCampfire,"LIFECYCLE");

    object oCookPot = CreateObject(OBJECT_TYPE_PLACEABLE, "cookpot", GetLocation(oCampfire));
    SetLocalInt(oCookPot,"LIFECYCLE",nLC);

    DestroyObject(oCampfire);

    //Set Lighting
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_5);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oCookPot));
    DelayCommand(1.5,RecomputeStaticLighting(GetArea(oCookPot)));

    AssignCommand(oCookPot,ExecuteScript("ocf_lifecycle",oCookPot));
}
