int StartingConditional()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
int myNeed = GetMaxHitPoints() - GetCurrentHitPoints();
int theirHP = GetCurrentHitPoints(oTarget);
return (myNeed < theirHP);
}
