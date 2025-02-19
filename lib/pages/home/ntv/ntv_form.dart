import 'package:ttld/helppers/form_validation.dart';
import 'package:ttld/widgets/field/field.dart';
import 'package:ttld/widgets/form/ny_form_data.dart';

class NtvForm extends NyFormData {
  NtvForm({String? name}) : super(name ?? "ntv_form");

  @override
  fields() => [
        Field.email("email",
            autofocus: true, style: "compact", validate: FormValidator.email()),
        Field.password("Password", style: "compact"),
        Field.checkbox("Remember me", style: "compact"),
        Field.url("URL", style: "compact", validate: FormValidator.url()),
        Field.text("Text", style: "compact"),
        Field.textArea("Textarea", style: "compact"),
        Field.chips("Chips",
            style: "compact", options: ["option 1", "option 2"]),
        Field.picker("Picker",
            style: "compact", options: ["option 1", "option 2"]),
        Field.switchBox("Switch box", style: "compact"),
        Field.date("Date", firstDate: DateTime(1900), lastDate: DateTime.now()),
      ];
}
