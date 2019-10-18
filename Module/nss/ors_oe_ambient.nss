////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Ambient Text Trigger
//  ors_oe_ambient
//  By Don Anderson
//  dandersonru@msn.com
//
//  Functions of Ambient (See Variables on Trigger to Set)
/*
    NOTE: You can set More than 1 on the Same Trigger =)

    - Slip and Fall (4 Random Float Strings)

    AOE PER Effects
    - Creeping Doom (Bugs..Bee Hive...Etc.)
    - Darkness
    - Acid Fog
    - Fog of Bewilderment
    - Entangle
    - Fire Fog
    - Ghoul Fog
    - Grease
    - Kaboom (Olander Sized Explosion =) )
    - Kill Fog (Cloud Kill)
    - Mind Fog
    - Stink Fog
    - Trog Stench
    - Tyrant Fog
    - Stone Hold
    - Storm of Vengence
    - Wall Blade (Blade Barrier)
    - Wall Fire
    - Web
    - Float a Statement Above the Player's Head.  (Once Per Reload)
*/
//
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC      = GetEnteringObject();
  object oTrigger = OBJECT_SELF;

  if(!GetIsPC(oPC)) return;

  ORS_AmbientTrigger(oPC,oTrigger);
}
