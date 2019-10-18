////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_lead_6m
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
//  Checks for Proper Owner and Sets the Following Distance.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;

  string sPC = GetLocalString(oNPC, "OPA_OWNER_NAME");
  string sCheck = GetName(oPC);

  if(sCheck == sPC) SetLocalFloat(oNPC,"OPA_DISTANCE",6.0);
}
