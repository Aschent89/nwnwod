string sDeny;
/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

#include "x2_inc_itemprop"
void RemoveXPFromParty(int nXP, object oPC, int bAllParty=TRUE)
{

if (!bAllParty)
   {
   nXP=(GetXP(oPC)-nXP)>=0 ? GetXP(oPC)-nXP : 0;
   SetXP(oPC, nXP);
   }
else
   {
   object oMember=GetFirstFactionMember(oPC, TRUE);

   while (GetIsObjectValid(oMember))
      {
      nXP=(GetXP(oMember)-nXP)>=0 ? GetXP(oMember)-nXP : 0;
      SetXP(oMember, nXP);
      oMember=GetNextFactionMember(oPC, TRUE);
      }
   }
}
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

RemoveXPFromParty(1500, oPC, FALSE);

AssignCommand(oPC, TakeGoldFromCreature(1500, oPC, TRUE));

if (!GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT, 35))
   {
   sDeny="You don't have the skill to do this.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
object oItem;
oTarget = oPC;


oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);

itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_COLD);

IPSafeAddItemProperty(oItem, ipAdd);

}
