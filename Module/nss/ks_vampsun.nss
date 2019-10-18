void main()
{
object oPC = GetEnteringObject();

    //Indoors Defined Area
    object oSunshinecheck = GetNearestObjectByTag("wp_inside",oPC);
    if(GetIsObjectValid(oSunshinecheck))
    {
    ExecuteScript("fvex_area_inside",OBJECT_SELF);
    }

    //Outdoors Defined Area
    object oSunshinecheck2 = GetNearestObjectByTag("wp_outside",oPC);
    if(GetIsObjectValid(oSunshinecheck2))
    {
    ExecuteScript("fvex_area_outsid",OBJECT_SELF);
    }
}
