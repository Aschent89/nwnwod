////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System
//  orw_mod_user
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is Called from the Module OnUser Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oMod = GetModule();

    //From Module Onload Event
    int nWEATHERGLOBAL = GetLocalInt(oMod,"WEATHERGLOBAL");
    if(nWEATHERGLOBAL == 0) return;

    //Now we get the areas that have the Weather Waypoint
    int nNth = 0;
    object oTVar = GetObjectByTag("T_VARIABLES",nNth);
    while(GetIsObjectValid(oTVar))
    {
      AssignCommand(oMod,ExecuteScript("orw_area_weather",oTVar));
      nNth++;
      oTVar = GetObjectByTag("T_VARIABLES",nNth);
    }
}
