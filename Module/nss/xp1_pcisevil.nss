// the PC is Evil
int StartingConditional()
{
    int iResult = GetAlignmentGoodEvil(GetPCSpeaker());
    if (iResult == ALIGNMENT_EVIL) return TRUE;
    else return FALSE;
}
