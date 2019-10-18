void main()
{
object oPC;

object oTarget;
object oSpawn;
location lTarget;
oPC = GetItemActivator();

lTarget = GetItemActivatedTargetLocation();

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "abyssgate", lTarget);

}
