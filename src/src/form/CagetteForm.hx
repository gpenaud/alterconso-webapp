package form;

import sugoi.form.Form;
import sugoi.form.elements.NativeDatePicker.NativeDatePickerType;

typedef FieldTypeToElementMap = Map<String, (name: String, label: String, value: Dynamic, ?required: Bool) -> Dynamic>;

class CagetteForm extends Form {

	override public static function fromSpod(obj:sys.db.Object, ?customMap:FieldTypeToElementMap) {
    	var fieldTypeToElementMap:FieldTypeToElementMap = null;
    	if(customMap!=null){
      		fieldTypeToElementMap = customMap;
    	}else{
      		fieldTypeToElementMap = new FieldTypeToElementMap();
      		fieldTypeToElementMap["DDate"] = CagetteForm.renderDDate;
      		fieldTypeToElementMap["DTimeStamp"] = CagetteForm.renderDTimeStamp;
      		fieldTypeToElementMap["DDateTime"] = CagetteForm.renderDTimeStamp;
    	}
        return sugoi.form.Form.fromSpod(obj, fieldTypeToElementMap);
  	}


	public static function renderDDate(name: String, label: String, value: Dynamic, ?required: Bool) {
		// hack
		var namesToOpenInYear = ['birthdate','birthday'];
		var openTo = "date";
		if (namesToOpenInYear.indexOf(name.toLowerCase()) != -1) {
			openTo = "year";
		}

		return new form.CagetteDatePicker(name, label, value, NativeDatePickerType.date, required, "", openTo);
	}

	public static function renderDTimeStamp(name: String, label: String, value: Dynamic, ?required: Bool) {
		return new form.CagetteDatePicker(name, label, value, NativeDatePickerType.datetime, required);
	}
}