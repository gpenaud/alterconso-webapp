package react.user;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.*;
import mui.core.styles.Styles;
import mui.core.styles.Classes;
import dateFns.DateFns;
import dateFns.DateFnsLocale;
import mui.icon.Delete;

typedef MembershipHistoryProps = {
    isLocked: Bool,
    userId: Int,
    groupId: Int,
    memberships: Array<{name:String,date:Date,id:Int,amount:Float}>,
    ?onDelete: () -> Void,
    ?onDeleteComplete: () -> Void,
};

typedef MembershipHistoryClasses = Classes<[headTableCell]>;

typedef MembershipHistoryPropsWithClasses = {
    >MembershipHistoryProps,
    classes: MembershipHistoryClasses,
};

@:publicProps(MembershipHistoryProps)
@:wrap(Styles.withStyles(styles))
class MembershipHistory extends ReactComponentOfPropsAndState<MembershipHistoryPropsWithClasses, { ?yearToDelete: Int }> {

    public static function styles(theme:Theme):ClassesDef<MembershipHistoryClasses> {
        return {
            headTableCell: {
                backgroundColor: "#F2EBD9",
                fontWeight: "900"
            },
        }
    }

    public function new(props: MembershipHistoryPropsWithClasses) {
        super(props);
        state = cast {};
    }

    override public function render() {
        var dialogIsOpened = state.yearToDelete != null;
        var res =
            <>
                <Table>
                    <TableHead>
                        <TableRow>
                            <TableCell className={props.classes.headTableCell} align=${mui.core.common.Align.Center}>Année</TableCell>
                            <TableCell className={props.classes.headTableCell} align=${mui.core.common.Align.Center}>Date de cotis.</TableCell>
                            <TableCell className={props.classes.headTableCell} align=${mui.core.common.Align.Center}>Montant</TableCell>
                            <TableCell className={props.classes.headTableCell} align=${mui.core.common.Align.Center}></TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        ${props.memberships.map(row -> renderRow(row))}
                    </TableBody>
                </Table>
                <Dialog open=$dialogIsOpened onClose=$closeDialog>
                    <DialogTitle>{"Supprimer cette adhésion ?"}</DialogTitle>
                    <DialogActions>
                    <Button onClick=$closeDialog>
                        Annuler
                    </Button>
                    <Button color=${mui.Color.Primary} variant={Contained} onClick=$delete>
                        Supprimer
                    </Button>
                    </DialogActions>
                </Dialog>
            </>
        ;

        return jsx('$res');
    }

    private function delete() {
        closeDialog();
        if (props.onDelete != null) props.onDelete();

        var url = '/api/user/deleteMembership/${props.userId}/${props.groupId}/${state.yearToDelete}';
        js.Browser.window.fetch(
            url
        ).then(function(res) {
            if (props.onDeleteComplete != null) props.onDeleteComplete();
        }).catchError(function(err) {
            trace(err);
        });
    }

    private function closeDialog() {
        this.setState({yearToDelete: null});
    }

    private function renderRow(row: Dynamic) {
        
        var onClick = function(e: js.html.Event) {
            this.setState({yearToDelete: row.id});
        };

        return 
            <TableRow key={row.id}>
                <TableCell align=${mui.core.common.Align.Center}>{row.name}</TableCell>
                <TableCell align=${mui.core.common.Align.Center}>{DateFns.format(new js.lib.Date(row.date), "d MMMM yyyy", {locale: DateFnsLocale.fr})}</TableCell>
                <TableCell align=${mui.core.common.Align.Center}>{row.amount}&nbsp;&euro;</TableCell>
                <TableCell align=${mui.core.common.Align.Center}>
                    <IconButton disabled=${props.isLocked} onClick=$onClick>
                        <Delete />
                    </IconButton>
                </TableCell>    
            </TableRow>
        ;
    }
}