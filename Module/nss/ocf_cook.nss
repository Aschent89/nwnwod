////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_cook
//  By Don Anderson
//  dandersonru@msn.com
//
//  Sets up Campfire with Spit
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    //Destroys Campfire and Sets up Cook Spit
    object oCampfire = GetNearestObjectByTag("Campfire");
    int nLC = GetLocalInt(oCampfire,"LIFECYCLE");

    object oCookSpit = CreateObject(OBJECT_TYPE_PLACEABLE, "cookspit", GetLocation(oCampfire));
    SetLocalInt(oCookSpit,"LIFECYCLE",nLC);

    DestroyObject(oCampfire);

    //Set Lighting
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_5);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oCookSpit));
    DelayCommand(1.5,RecomputeStaticLighting(GetArea(oCookSpit)));

    AssignCommand(oCookSpit,ExecuteScript("ocf_lifecycle",oCookSpit));
}
