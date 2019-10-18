string sDeny;
void main()
{

object oPC = GetLastClosedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "mage_matt_5")== OBJECT_INVALID)
   {
   sDeny="You are not skilled in the way of matter to work with this";

   SendMessageToPC(oPC, sDeny);

   return;
   }
    ExecuteScript("orc_st_enchant",OBJECT_SELF); //If has item craft magical stuff

}
