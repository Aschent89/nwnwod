#include "nw_i0_tool"

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "mage_pouch")== OBJECT_INVALID)
   return;

if (GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT, 48))
   {
   SendMessageToPC(oPC, "You can sense a object of great magical importance inside this statue.");
   RewardPartyXP(50, oPC, FALSE);

   }
else if (GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT, 28))
   {
   SendMessageToPC(oPC, "This statue holds something magical but you are not yet skilled enough to know what it is.");
   RewardPartyXP(25, oPC, FALSE);
   }
else
   {
   SendMessageToPC(oPC, "There is some form of magikal enegy in this statue.");
   RewardPartyXP(10, oPC, FALSE);
   }
}
