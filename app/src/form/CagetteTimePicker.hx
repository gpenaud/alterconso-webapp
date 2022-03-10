package form;

import sugoi.form.elements.NativeDatePicker;
import sugoi.form.elements.NativeDatePicker.NativeDatePickerType;

class CagetteTimePicker extends CagetteDatePicker {

    public function new(name,label,value,?required,?attributes){
        super(name,label,value,NativeDatePickerType.time,required,attributes);
    }
  
}