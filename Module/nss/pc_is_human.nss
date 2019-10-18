int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "human") return FALSE;

return TRUE;
}

