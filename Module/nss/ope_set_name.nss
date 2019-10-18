////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Pets
//  ope_set_name
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pet Convo.
//
//  Sets the Listening of the Pet for Naming It.
//
////////////////////////////////////////////////////////////////////////////////


void main()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;

  SetListenPattern(oAnimal, "**", 60012);
  SetListening(oAnimal, TRUE);
  SetLocalObject(oAnimal, "CurrentPC", oPC);
}
