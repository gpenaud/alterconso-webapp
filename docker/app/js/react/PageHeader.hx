package react;

import react.ReactComponent;
import react.ReactMacro.jsx;
import mui.core.common.CSSPosition;
import mui.core.Hidden;
import utils.HttpUtil;
import react.mui.CagetteTheme.CGColors;

import mui.core.*;

import Common;
using Lambda;

typedef PageHeaderProps = {/*userRights:Rights,*/groupName:String,userName:String,userId:Int};

class PageHeader extends react.ReactComponentOfPropsAndState<PageHeaderProps,{anchorMenu:js.html.Element}> {
	
   
    public function new() {
		super();
        state = {anchorMenu:null};
	}

    override public function render(){

        /*var members = hasRight(Right.Membership) ? jsx('<$Tab label="ADHÉRENTS" value="members"/>') : null;
        var contracts = hasRight(Right.ContractAdmin()) ? jsx('<$Tab label="CONTRATS" value="contracts"/>') : null;
        var messages = hasRight(Right.Messages) ? jsx('<$Tab label="MESSAGERIE" value="messages"/>') : null;
        var group = hasRight(Right.GroupAdmin) ? jsx('<$Tab label="GROUPE" value="group"/>') : null;*/
        var members = null;
        var contracts = null;
        var messages = null;
        var group = null;

        var anchorEl = state.anchorMenu;

        return jsx('
            <Grid container justify=${Center} style=${{marginBottom:0,maxWidth:"1240px",marginLeft:"auto",marginRight:"auto"}}>
                
                <Grid item md={6} xs={12}>
                    <h1 style={{marginTop:8,marginBottom:8}}><a href="/" style=${{textDecoration:"none",color:CGColors.DarkGrey}}>${props.groupName}</a></h1>
                </Grid>

                <Hidden xsDown>
                <Grid item md={6} xs={false} style=${{textAlign:"right"}}>
                    <div>
                        <$Button onClick=$changeGroup >
                            <i className="icon icon-chevron-left"></i> Accueil
                        </$Button>
                        <$Button onClick=$onUserMenuOpen aria-owns=${anchorEl!=null ? "simple-menu" : null} aria-haspopup>
                            <i className="icon icon-user"></i> ${props.userName}
                        </$Button>
                        <$Menu id="simple-menu"
                        anchorEl=${anchorEl}
                        open=${anchorEl!=null}
                        onClose=$onUserMenuClose>
                            <$MenuItem onClick=${ cast onUserMenuClick} key="logout" value="logoute">
                                <i className="icon icon-delete"></i> Déconnexion
                            </$MenuItem>
                        </$Menu>
                    </div>
                </Grid>
                </Hidden>

                <!--<$Grid item xs={12}>
                    <$AppBar position=${CSSPosition.Static} color=${mui.Color.Default}>
                        <$Tabs onChange=${ cast handleChange} value="home">
                            <$Tab label="ACCUEIL" value="home"/>
                            <$Tab label="MON COMPTE" value="account"/>
                            <$Tab label="PRODUCTEURS" value="farmers"/>

                            $members
                            $contracts
                            $messages
                            $group
                            
                        </$Tabs>
                    </$AppBar>
                </$Grid>-->
            </Grid>
        ');
    }

    /**
        TODO : this kind of signature is not implemented in the extern
    **/
    public function handleChange(_,value:String){
        
        js.Browser.window.location.href = switch(value){
            case "account":"/contract";
            case "farmers":"/amap";
            case "members":"/member";
            case "contracts":"/contractAdmin";
            case "messages":"/messages";
            case "group":"/amapadmin";
            case "admin":"/admin";
            default : "/";

        } ; 
    }

    function onUserMenuClose(event:js.html.Event,cause:mui.core.modal.ModalCloseReason){

        this.setState({ anchorMenu:null});

    }

    function onUserMenuClick(event:js.html.Event,value:String){
//<a href="/user/choose?show=1">
//<a href="/user/logout">
        
        trace(untyped event.currentTarget.value);
        trace(untyped event.currentTarget.key);
        trace(untyped event.target.value);
        trace(untyped event.target.key);
        trace(untyped event.value);
        trace(untyped event.key);
        trace(untyped value);

        this.setState({ anchorMenu:null});

    }

    function onUserMenuOpen(event:js.html.Event){
        return false;
        
        // trace(event.currentTarget);
        this.setState({ anchorMenu:cast event.currentTarget});
    }

/*
    public function hasRight(r:Right):Bool {
		if (props.userRights == null) return false;
		for ( right in props.userRights) {
			if ( Type.enumEq(r,right) ) return true;
		}
		return false;
	}*/

    function changeGroup(_){
        js.Browser.window.location.href = "/user/choose?show=1";
    }
}
