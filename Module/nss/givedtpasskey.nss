void main()
{

object oPC = GetPCSpeaker();

if (GetGold(oPC) >= 50)
   {
   AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));

   CreateItemOnObject("darktemplepass", oPC);

   }
else
   {
   SendMessageToPC(oPC, "You dont have enough coins!");

   }

}

