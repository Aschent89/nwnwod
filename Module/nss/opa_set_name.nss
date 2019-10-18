////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Pack Animals
//  opa_set_name
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Convo.
//
//  Sets the Listening of the Pack Animal for Naming It.
//
////////////////////////////////////////////////////////////////////////////////


void main()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;

  SetListenPattern(oAnimal, "**", 60011);
  SetListening(oAnimal, TRUE);
  SetLocalObject(oAnimal, "CurrentPC", oPC);
}
