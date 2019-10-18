int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "vampire") return FALSE;

return TRUE;
}

