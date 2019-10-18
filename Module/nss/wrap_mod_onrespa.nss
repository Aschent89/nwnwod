////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onrespa
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    //From Master Configuration opw_mod_onload
    string sRespawnSystem = GetLocalString(GetModule(),"RESPAWNSYSTEM");
    ExecuteScript(sRespawnSystem,OBJECT_SELF);
//   ExecuteScript("habd_onpcrespawn",OBJECT_SELF);
    //From Master Configuration opw_mod_onload
    ExecuteScript("ohtf_mod_respawn",OBJECT_SELF); //HTF System
}
