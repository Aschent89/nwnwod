void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("StravoBellTowerRings1");

SoundObjectPlay(oTarget);

DelayCommand(11.0, SoundObjectStop(oTarget));

oTarget = GetObjectByTag("StravoBellTowerRings2");

SoundObjectPlay(oTarget);

DelayCommand(11.0, SoundObjectStop(oTarget));

oTarget = GetObjectByTag("StravoBellTowerRings3");

SoundObjectPlay(oTarget);

DelayCommand(11.0, SoundObjectStop(oTarget));

oTarget = GetObjectByTag("StravoBellTowerRings4");

SoundObjectPlay(oTarget);

DelayCommand(11.0, SoundObjectStop(oTarget));

}

