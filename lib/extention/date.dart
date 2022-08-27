extension MyDateExtention on DateTime{
  DateTime getDateOnly(){
    return DateTime(this.year,this.month,this.year);
  }
}