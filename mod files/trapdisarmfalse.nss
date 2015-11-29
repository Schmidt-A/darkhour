void main(){
    SetTrapRecoverable(OBJECT_SELF,FALSE);
    DelayCommand(12.0f,SetTrapActive(OBJECT_SELF,TRUE));
}
