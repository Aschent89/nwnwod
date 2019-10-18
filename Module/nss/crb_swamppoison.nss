//  Caines poison fort save trigger.

//Put this script OnEnter

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (FortitudeSave(oPC, 15, SAVING_THROW_TYPE_DISEASE ))
   {
   }
else
SendMessageToPC(oPC, "The stench around this area is horrid, to the point it almost makes you nauseaus.");
{
   }
   }
