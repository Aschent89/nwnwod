void main()
{
    object oPC = GetItemActivator();

    //Indoors Defined Area
    object oUmbraCheck = GetNearestObjectByTag("wp_umbra",oPC);
    if(GetIsObjectValid(oUmbraCheck))
    {
    ExecuteScript("knight2",OBJECT_SELF);
    }

    //Outdoors Defined Area
    object oUmbraCheck2 = GetNearestObjectByTag("wp_nonumbra",oPC);
    if(GetIsObjectValid(oUmbraCheck2))
    {
    ExecuteScript("ks_umbrapath",OBJECT_SELF);
    }
}
