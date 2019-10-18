////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_conv_mount
//  by Don Anderson
//  dandersonru@msn.com
//
//  Mounts the Horse
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  object oCityProper = GetNearestObjectByTag("CityProper",oPC);

  //No Riding in Interior Areas
  if(GetIsObjectValid(oCityProper))
  {
    //No Riding In Places that Don't Allow Riding Horses
    SendMessageToPC(oPC,"This is an Area that does NOT allow Riding Horses.");
  }
  else OHOMountHorse(oPC, oAnimal);
}
