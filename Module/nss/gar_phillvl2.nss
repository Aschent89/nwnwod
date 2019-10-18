void main()
{
object oPC;

if ((GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE)
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}


oPC = GetItemActivatedTarget();

if (GetStringLowerCase(GetSubRace(oPC))=="vampire")
   {
   SendMessageToPC(oPC, "A leech stands before you.");

   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Metis")
   {
   SendMessageToPC(oPC, "This person is a Garou.");

   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Lupis")
   {
   SendMessageToPC(oPC, "This person is a Garou.");

   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Homid")
   {
   SendMessageToPC(oPC, "This person is a Garou.");

   }
else
   {
   FloatingTextStringOnCreature("Nothing but a simple human.", oPC);

   }

}
