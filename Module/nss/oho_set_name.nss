////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_set_name
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Convo.
//
//  Sets the Listening of the Horse for Naming It.
//
////////////////////////////////////////////////////////////////////////////////


void main()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;

  SetListenPattern(oHorse, "**", 60010);
  SetListening(oHorse, TRUE);
  SetLocalObject(oHorse, "CurrentPC", oPC);
}
