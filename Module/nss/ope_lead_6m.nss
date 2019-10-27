////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_lead_6m
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pet Convo.
//
//  Checks for Proper Owner and Sets the Following Distance.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;

  string sPC = GetLocalString(oNPC, "OPE_OWNER_NAME");
  string sCheck = GetName(oPC);

  if(sCheck == sPC) SetLocalFloat(oNPC,"OPE_DISTANCE",6.0);
}