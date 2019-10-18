// the PC has at least 1 level Wizard
int StartingConditional()
{
    int iResult;

    iResult = GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) > 0;
    return iResult;
}
