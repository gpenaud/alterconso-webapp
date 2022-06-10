package react.user;

import haxe.Timer;
import css.TextAlign;
import mui.core.common.Breakpoint;
import react.types.HandlerOrVoid;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import react.mui.Alert;
import react.mui.Box;
import mui.core.*;
import mui.core.Tabs;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.icon.Close;
import react.user.MemberShipForm;
import react.user.MembershipHistory;

typedef TClasses = Classes<[modal, card, loaderContainer]>;

typedef MembershipDialogProps = {
    userId: Int,
    groupId: Int,
    ?distributionId:Int,
    callbackUrl: String,
};

typedef MembershipDialogPropsWithClasses = {
    >MembershipDialogProps,
    var classes:TClasses;
};

typedef MembershipDialogState = {
    isOpened: Bool,
    isLoading: Bool,
    isLocked: Bool,
    tabIndex: Int,
    canAdd: Bool,
    submitSuccess: Bool,

    userName:String,
    availableYears:Array<{name:String,id:Int}>,
    memberships:Array<{name:String,date:Date,id:Int,amount:Float}>,
    distributions:Array<{name:String,id:Int}>,
    paymentTypes:Array<{id:String,name:String}>,
    ?membershipFee:Int,
}

@:publicProps(MembershipDialogProps)
@:wrap(Styles.withStyles(styles))
class MembershipDialog extends ReactComponentOfPropsAndState<MembershipDialogPropsWithClasses, MembershipDialogState> {

    private var submitSuccessTimer: Timer;

    public static function styles(theme:Theme):ClassesDef<TClasses> {
        return {
            modal: {
                display: 'flex',
                alignItems: css.AlignItems.Center,
                justifyContent: css.JustifyContent.Center,
            },
            card: {
                width: 610,
            },
            loaderContainer: {
                minWidth: 610,
                minHeight: 300,
                display: "flex",
                alignItems: css.AlignItems.Center,
                justifyContent: css.JustifyContent.Center,
            }
        }
    }

	public function new(props : MembershipDialogPropsWithClasses) {
        super(props);
        state = cast {
            isOpened : true,
            isLoading: true,
            tabIndex: 0,
            canAdd: true,
            submitSuccess: false,
        };    
    }

    override function componentDidMount() {
        loadData();
    }

    override function componentWillUnmount() {
        stopSubmitSuccessTimer();
    }

  	override public function render() {
        var content;

        if (state.userName == null) {
            content = <CircularProgress />; 
        } else {
            var cardTitle = 'Adhésions de ${state.userName}';
            content = 
                <Card className=${props.classes.card}>
                    <CardHeader
                        title={
                            <Box display="flex" justifyContent="space-between" alignItems="center">
                                <Box width={48} height={48}></Box>
                                <Typography>$cardTitle</Typography>
                                <Box width={48} height={48}>
                                    <IconButton onClick=$onClose disabled=${state.isLocked}>
                                        <Close />
                                    </IconButton>
                                </Box>
                            </Box>
                        }
                        />
                    <AppBar position=${mui.core.common.CSSPosition.Static}>
                        <Tabs
                            centered
                            value=${state.tabIndex}
                            onChange=$onTabChange
                        >
                            <Tab label="Historique" disabled=${state.isLocked} />
                            <Tab label="Ajouter" disabled=${state.isLocked || state.availableYears.length == 0} />
                        </Tabs>
                    </AppBar>
                    <Collapse in=${state.submitSuccess}>
                        <Box m={2}>
                            <Alert severity="success">Nouvelle adhésion enregistrée</Alert>
                        </Box>
                    </Collapse>
                    ${renderTab()}
                    ${renderLoader()}
                </Card>
            ;
        }

        var res =
            <Modal open=${state.isOpened} className=${props.classes.modal} onClose=$onClose>
                $content
            </Modal>
        ;

        return jsx('$res');
    }

    private function loadData() {
        setState({ isLoading: true });

        var url = '/api/user/membership/${props.userId}/${props.groupId}';
        js.Browser.window.fetch(url)
            .then(res -> res.json())
            .then(res -> {
                var availableYears = res.availableYears.filter(y -> {
                    var finded = res.memberships.find(mY -> y.id == mY.id);
                    return finded == null;
                });

                setState({
                    isLoading : false,
                    isLocked: false,
                    tabIndex: 0,

                    userName : res.userName,
                    paymentTypes : res.paymentTypes,
                    availableYears : cast availableYears,
                    memberships : cast res.memberships,
                    membershipFee : res.membershipFee,
                    distributions : res.distributions,
                });
            });
    }

    private function onClose() {
        if (!state.isLocked) setState({ isOpened: false });

        //reload host page after closing window
        if(props.callbackUrl!=null){
            haxe.Timer.delay(function(){
                js.Browser.document.location.href = props.callbackUrl;
            },250);
        }
    }

    private function onTabChange(e: js.html.Event, newValue: Int) {
        this.setState({ tabIndex: newValue });
    }

    private function renderTab() {
        if (state.isLoading) {
            return <div className=${props.classes.loaderContainer}><CircularProgress /></div>;
        }

        if (state.tabIndex == 0) {
            return 
                <MembershipHistory
                    isLocked=${state.isLocked}
                    userId=${props.userId}
                    groupId=${props.groupId}
                    memberships={state.memberships}
                    onDelete=$lock
                    onDeleteComplete=$loadData
                />;
        }

        if (state.availableYears.length == 0) {
            return null;
        }

        return 
            <MemberShipForm
                userId=${props.userId}
                groupId=${props.groupId}
                availableYears=${state.availableYears}
                paymentTypes=${state.paymentTypes}
                membershipFee=${state.membershipFee}
                distributions=${state.distributions}
                distributionId=${props.distributionId}
                onSubmit=$lock
                onSubmitComplete=$onSubmitComplete
            />
        ;
    }

    private function onSubmitComplete(success: Bool) {
        stopSubmitSuccessTimer();
        setState({ submitSuccess: success });

        if (success) {
            submitSuccessTimer = new Timer(5000);
            submitSuccessTimer.run = function() {
                setState({ submitSuccess: false });
            };
        }

        loadData();
    }

    private function renderLoader() {
        if (!state.isLocked) return null;
        return <LinearProgress />;
    }

    private function lock() {
        setState({ isLocked: true });
    }

    private function stopSubmitSuccessTimer() {
        if (submitSuccessTimer != null) submitSuccessTimer.stop();
    }
}