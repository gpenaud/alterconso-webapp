package dateFns;

import dateIO.DateFnsUtils;

class FrDateFnsUtils extends DateFnsUtils {

    public function new(props: Dynamic) {
      super(props);
    }
  
    override public function getDatePickerHeaderText(date: Date) {
      return DateFns.format(date, "d MMM yyyy", { locale: this.locale });
    }
  
    override public function getCalendarHeaderText(date: Date) {
      return DateFns.format(date, "d MMM yyyy", { locale: this.locale });
    }
  }