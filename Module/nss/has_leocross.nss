int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "hunter_leocross") == OBJECT_INVALID) return FALSE;

return TRUE;
}
