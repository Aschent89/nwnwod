/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.5

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();
int nLaw = GetAlignmentGoodEvil(oPC);

if (nLaw == ALIGNMENT_EVIL)
    AdjustAlignment(oPC, ALIGNMENT_GOOD, 50);
else if (nLaw == ALIGNMENT_GOOD)
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 50);

AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 100);

}

