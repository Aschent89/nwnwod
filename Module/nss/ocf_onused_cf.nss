////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_onused_cf
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    //From Master Configuration ors_mod_onload
    int nRESTGLOBAL = GetLocalInt(GetModule(),"RESTGLOBAL");
    if(nRESTGLOBAL == 0) return;

    AssignCommand(GetLastUsedBy(), ActionStartConversation(OBJECT_SELF, "ocf_conv", TRUE));
}
