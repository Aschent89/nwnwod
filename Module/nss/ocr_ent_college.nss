////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Education/Crafting College Prospectus Trigger
//  ocr_ent_college
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is used to place right at the entrance (Inside is Best) of the College
//  To give a College Prospectus to every player who does not have one.
//
//  Place this script in the Trigger On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetEnteringObject();
    object oMod     = GetModule();

    string sSRTag = "CollegeProspectus";
    string sSRResRef = "prospectus";

    //From Master Configuration ors_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oTrigger = OBJECT_SELF;

    string sTName   = GetName(oTrigger);
    string sTTag    = GetTag(oTrigger);

    //Is this a DM?
    if(GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE) return;

    //Check if Classroom Trigger is College Prospectus
    if(sTTag == "CollegeProspectus")
    {
      if(GetIsPC(oPC) == TRUE)
      {
        object oBook = GetItemPossessedBy(oPC,sSRTag);

        if(oBook == OBJECT_INVALID)
        {
          CreateItemOnObject(sSRResRef,oPC);
          SendMessageToPC(oPC,"I have received a College Prospectus with information on College Courses.");
        }
      }
    }
}
