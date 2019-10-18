void main()
{
    DelayCommand( 10.0, ActionCloseDoor( OBJECT_SELF ));
    DelayCommand( 10.1, SetLocked( OBJECT_SELF, TRUE ));
}
