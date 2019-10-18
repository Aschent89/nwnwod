void main()
{
object oPC;

if (GetIsObjectValid(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

object oTarget;
object oSpawn;
location lTarget;
oPC = GetItemActivator();

oTarget = oPC;

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "vicissitudeporta", lTarget);

}
