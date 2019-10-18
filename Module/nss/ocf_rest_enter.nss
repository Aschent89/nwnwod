////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_rest_enter
//  by Don Anderson
//  dandersonru@msn.com
//
//  This is to allow resting in specific areas
//  Script By : Deva Bryson Winblood
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    //From Master Configuration ors_mod_onload
    int nRESTGLOBAL = GetLocalInt(GetModule(),"RESTGLOBAL");
    if(nRESTGLOBAL == 0) return;

    object oPC=GetEnteringObject();

    if (GetIsPC(oPC)==TRUE)
    {
      SetLocalInt(oPC,"REST_ALLOWED",TRUE);
      SetLocalInt(oPC,"TENT", TRUE);
      SendMessageToPC(oPC,"This looks like a good place to rest.");
    }
}
