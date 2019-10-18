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
   SendMessageToPC(GetItemActivator(), "A leech stands before you.");
   FloatingTextStringOnCreature("A leech stands before you.", oPC);
   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Metis")
   {
   SendMessageToPC(GetItemActivator(), "This person is a Garou.");
    FloatingTextStringOnCreature("This person is a Garou.", oPC);
   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Lupis")
   {
   SendMessageToPC(GetItemActivator(), "This person is a Garou.");
    FloatingTextStringOnCreature("This person is a Garou.", oPC);
   }
   else if (GetStringLowerCase(GetSubRace(oPC))=="Garou_Homid")
   {
   SendMessageToPC(GetItemActivator(), "This person is a Garou.");
    FloatingTextStringOnCreature("This person is a Garou.", oPC);
   }
else
   {
   FloatingTextStringOnCreature("Nothing but a simple human.", oPC);
       FloatingTextStringOnCreature("Nothing but a simple human.", oPC);
   }

}
