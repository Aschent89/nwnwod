/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.1

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "vamp_pote_5") == OBJECT_INVALID) return FALSE;

return TRUE;
}
