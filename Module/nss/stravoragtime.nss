void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("Stravopianist");

SoundObjectPlay(oTarget);

oTarget = GetObjectByTag("Stravoragtime");

DelayCommand(5.0, SoundObjectPlay(oTarget));

}

