int StartingConditional()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
SetCustomToken(668, GetName(oTarget));
return GetIsObjectValid(oTarget);
}
