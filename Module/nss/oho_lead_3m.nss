////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_lead_3m
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Checks for Proper Owner and Sets the Following Distance.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;

  string sPC = GetLocalString(oNPC, "OHO_OWNER_NAME");
  string sCheck = GetName(oPC);

  if(sCheck == sPC) SetLocalFloat(oNPC,"OHO_DISTANCE",3.0);
}
