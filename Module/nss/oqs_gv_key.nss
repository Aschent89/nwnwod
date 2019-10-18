////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_gv_key
//  By Don Anderson
//  dandersonru@msn.com
//
//  Gives a Specific Key in Local Variable  "SPEC_KEY"
//
//  Use this in Conversations to Give this Key to Access a Quest
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  CreateItemOnObject(GetLocalString(OBJECT_SELF,"SPEC_KEY"),oPC);
}
