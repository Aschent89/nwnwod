/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.3

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt = GetLocalInt(oPC, "wizcrime");

nInt += 1;

SetLocalInt(oPC, "wizcrime", nInt);

}
