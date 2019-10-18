////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_t_add
//  By Don Anderson
//  dandersonru@msn.com
//
//  Add PC Tatoo
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  SetCreatureBodyPart(CREATURE_PART_TORSO, CREATURE_MODEL_TYPE_TATTOO, oPC);
}
