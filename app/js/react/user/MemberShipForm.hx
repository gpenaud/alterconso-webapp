package react.user;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.formik.Formik;
import react.formik.Form;
import react.formik.Field;
import react.formikMUI.TextField;
import react.formikMUI.Select;
import react.formikMUI.DatePicker;
import react.mui.pickers.MuiPickersUtilsProvider;
import mui.core.*;
import mui.core.styles.Styles;
import mui.core.styles.Classes;
import react.mui.CagetteTheme;
import react.mui.Box;
import dateFns.DateFnsLocale;
import dateFns.FrDateFnsUtils;

typedef MemberShipFormProps = {
    userId: Int,
    groupId: Int,
    availableYears: Array<{name:String,id:Int}>,
    paymentTypes: Array<{id:String,name:String}>,
    distributions:Array<{name:String,id:Int}>,
    ?distributionId:Int,
    ?membershipFee: Int,
    ?onSubmit: () -> Void,
    ?onSubmitComplete: (success: Bool) -> Void,
};

typedef MemberShipFormClasses = Classes<[datePickerInput, snack, snackMessage]>;


typedef MemberShipFormPropsWithClasses = {
    >MemberShipFormProps,
    classes:MemberShipFormClasses,
};

typedef FormProps = {
    date: Date,
    year: Int,
    membershipFee: Int,
    paymentType: String,
    distributionId: Int,
};

@:publicProps(MemberShipFormProps)
@:wrap(Styles.withStyles(styles))
class MemberShipForm extends ReactComponentOfProps<MemberShipFormPropsWithClasses> {

    public static function styles(theme:Theme):ClassesDef<MemberShipFormClasses> {
        return {
            datePickerInput: {
                textTransform: css.TextTransform.Capitalize
              },
            snack: {
                backgroundColor: "#f44336"
            },
            snackMessage: {
                width: "100%",
                textAlign: "center",
                color: "#FFF",
            }
        }
    }

    override public function render() {
        var now = Date.now();
        var findedDefaulYear = props.availableYears.find(y -> y.id == now.getFullYear());
        var defaultYearId = findedDefaulYear != null ? findedDefaulYear.id : props.availableYears[0].id;
        
        var defaultDistributionId = props.distributionId != null ? props.distributionId : -1;
        
        var res =
            <MuiPickersUtilsProvider utils={FrDateFnsUtils} locale=${DateFnsLocale.fr} >
                <Formik
                    initialValues={{
                        date: new js.lib.Date(),
                        year: defaultYearId,
                        membershipFee: (props.membershipFee == null) ? 0 : props.membershipFee,
                        paymentType: props.paymentTypes.length>0 ? props.paymentTypes[0].id : null,
                        distributionId: defaultDistributionId
                    }}
                    onSubmit=$onSubmit
                >
                    {formikProps -> (
                        <Form>
                            {renderStatus(formikProps.status)}
                            <CardContent>
                                <FormControl fullWidth>
                                <Field
                                    component={DatePicker}
                                    InputProps={{
                                        classes: {
                                        input: ${props.classes.datePickerInput}
                                        }
                                    }}
                                    label="Date de cotisation"
                                    cancelLabel="Annuler"
                                    name="date"
                                    format="EEEE d MMMM yyyy"
                                    required  />
                            </FormControl>
                                
                                <FormControl fullWidth margin=${mui.core.form.FormControlMargin.Normal}>
                                    <InputLabel htmlFor="mb-year">Année</InputLabel>
                                    <Field component={Select} inputProps={{id: "mb-year"}} name="year" fullWidth required>
                                        ${props.availableYears.map(y -> <MenuItem key=${y.id} value=${y.id}>${y.name}</MenuItem>)}
                                    </Field>
                                </FormControl>
                                
                                <FormControl fullWidth margin=${mui.core.form.FormControlMargin.Normal}>
                                    <Field
                                        component={TextField}
                                        fullWidth
                                        required
                                        name="membershipFee"
                                        label="Montant"
                                        InputProps={{
                                            endAdornment: "€",
                                        }}
                                        inputProps={{
                                            min: 0,
                                            step: 0.01
                                        }}
                                        type=${mui.core.input.InputType.Number}
                                    />
                                </FormControl>
                                
                                {renderPaymentTypeField()}
                                {renderDistributionField()}
                                
                            </CardContent>
                            <CardActions>
                                <Box my={2} display="flex" justifyContent="center" width="100%">
                                    <Button
                                        disabled=${formikProps.isSubmitting}
                                        variant=${mui.core.button.ButtonVariant.Contained}
                                        color=$Primary
                                        type=${mui.core.button.ButtonType.Submit}
                                    >
                                        Valider
                                    </Button>
                                </Box>
                            </CardActions>
                        </Form>
                    )}
                </Formik>
            </MuiPickersUtilsProvider>
        ;

        return jsx('$res');
    }

    private function renderPaymentTypeField(){
        if(props.paymentTypes==null || props.paymentTypes.length==0){
            return null;
        }else{
            return <FormControl fullWidth margin=${mui.core.form.FormControlMargin.Normal}>
                <InputLabel htmlFor="mb-payment">Paiement</InputLabel>
                <Field component={Select} inputProps={{id: "mb-payment"}} name="paymentType" fullWidth required>
                    ${props.paymentTypes.map(p -> <MenuItem key=${p.id} value=${p.id}>${p.name}</MenuItem>)}
                </Field>
            </FormControl>;
        }
    }

    private function renderDistributionField() {
        if (props.distributions.length < 1) return null;
        return 
            <FormControl fullWidth margin=${mui.core.form.FormControlMargin.Normal}>
                <InputLabel htmlFor="mb-distrib">Lors de la distribution</InputLabel>
                <Field component={Select} inputProps={{id: "mb-distrib"}} name="distributionId" fullWidth>
                    <MenuItem value={-1}><span>&nbsp;</span></MenuItem>
                    ${props.distributions.map(d -> <MenuItem key=${d.id} value=${d.id}>${d.name}</MenuItem>)}
                </Field>
            </FormControl>
        ;
    }

    private function renderStatus(?status: Dynamic) {
        if (status == null) return null;
        return 
            <CardContent>
                <SnackbarContent
                    classes={{ 
                        root: props.classes.snack,
                        message: props.classes.snackMessage
                    }}
                    message=$status />
            </CardContent>
        ;
    }

    private function onSubmit(values: FormProps, formikBag: Dynamic) {
        formikBag.setStatus(null);
        if (props.onSubmit != null) props.onSubmit();

        var url = '/api/user/membership/${props.userId}/${props.groupId}';

        var data = new js.html.FormData();
        data.append("date", values.date.toString());
        data.append("year", Std.string(values.year));
        data.append("membershipFee", Std.string(values.membershipFee));
        data.append("paymentType", values.paymentType);
        if (values.distributionId != null || values.distributionId != -1) data.append("distributionId", Std.string(values.distributionId));

        js.Browser.window.fetch(url, {
            method: "POST",
            body: data
        }).then(function(res) {
            formikBag.setSubmitting(false);
            if (props.onSubmitComplete != null) props.onSubmitComplete(res.ok);

            if (!res.ok) {
                formikBag.setStatus("Un erreur est survenue");
                throw res.statusText;
            }
            
            return true;
        }).catchError(function(err) {
            trace(err);
        });
    }
}