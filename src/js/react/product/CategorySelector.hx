package react.product;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;
import mui.core.*;
import react.mui.CagetteTheme;
using Lambda;

private typedef Props = {
	categories : Array<CategoryInfo>,
	onSelect:Int->Void,
	onClose:js.html.Event->mui.core.modal.ModalCloseReason->Void,
}

class CategorySelector extends react.ReactComponentOfPropsAndState<Props,{}>{

	public function new(props){
		super(props);
		this.state = {};		
	}

	override public function render(){
		//faire des Item comme là ? https://material-ui.com/demos/dialogs/
		return jsx('
			<Dialog onClose=$close open={true} >
				<Typography component="h2" style=${{fontSize:"1.3rem",padding:12,marginTop:12}}>
					Sélectionnez une catégorie
				</Typography>
				<SelectionPanel categories=${this.props.categories} onSelect=${props.onSelect}/>
				<DialogActions>
					<Button onClick=${close}>
                        ${CagetteTheme.getIcon("delete")} Fermer
                    </Button>
				</DialogActions>
        	</Dialog>');
	}

	function close(e){
		props.onClose(e,mui.core.modal.ModalCloseReason.BackdropClick);
    }

}

typedef SelectionPanelProps = {
	categories : Array<CategoryInfo>,
	onSelect:Int->Void,
}

typedef SelectionPanelState = {
	category1Id:Int,
	category2Id:Int,
	category3Id:Int
}

class SelectionPanel extends react.ReactComponentOfPropsAndState<SelectionPanelProps,SelectionPanelState>{

	public function new(props) 
	{
		super(props);
		this.state = {
			category1Id:0,
			category2Id:0,
			category3Id:0
		};
	}

	function getPath() {
        var path = "";
        var category1Id = this.state.category1Id;
        var category2Id = this.state.category2Id;
        var category3Id = this.state.category3Id;

        if (category1Id != 0) {
            path = this.getLevelCategories(1, 0, 0).filter(function(data) return data.id == category1Id )[0].name;
        }

        if (category2Id != 0) {
            path += " / " + this.getLevelCategories(2, category1Id, 0).filter(function(data) return data.id == category2Id )[0].name;
        }

        if (category3Id != 0) {
            path += " / " + this.getLevelCategories(3, category1Id, category2Id).filter(function(data) return data.id == category3Id )[0].name;
        }

        return path;
    }

        
	/**
		Click on a category on any level
	**/
	function handleClick(id:Int) {

		if (this.state.category1Id==0) {
			this.setState({ category1Id: id });              
		} else if (this.state.category2Id==0) {
			this.setState({ category2Id: id });
		} else if (this.state.category3Id==0) {
			this.setState({ category3Id: id },function(){
				this.props.onSelect(id);
			});
		}
	}

	function getProductCategories() {

		var productCategories = [];
		var category1Id = this.state.category1Id;
		var category2Id = this.state.category2Id;
		
		//Level 1
		if (category1Id == 0) {
			productCategories = this.getLevelCategories(1, 0, 0);
		} 
		//Level 2          
		else if (category2Id == 0) {
			productCategories = this.getLevelCategories(2, category1Id, 0);
		}
		//Level 3
		else {            
			productCategories = this.getLevelCategories(3, category1Id, category2Id);
		}

		return productCategories;

	}

	function getLevelCategories(level:Int, category1Id:Int, category2Id:Int) {
		if (level == 1) {
			return this.props.categories;
		} else if(level == 2) {
			return this.props.categories.filter(function(data) return data.id == category1Id )[0].subcategories;
		} else {
			var categories2 = this.props.categories.filter(function(data) return data.id == category1Id )[0].subcategories;
			return categories2.filter(function(data) return data.id == category2Id )[0].subcategories;
		}
	}

	override function render() {

		var productCategories = this.getProductCategories().map(function (item){
			var onClick = function(){
				handleClick(item.id);
			}; 

			if(state.category1Id==0){
				return jsx('<ListItem button onClick=$onClick key=${item.id}>
				<ListItemAvatar>
                	<img src=${item.image} style=${{width:64}}/>
                </ListItemAvatar>
				<ListItemText primary=${item.name} />
				</ListItem>');
			}else{
				return jsx('
			 		<ListItem button onClick=$onClick key=${item.id}>
                		<ListItemText primary=${item.name} />
              		</ListItem>');
			}
			
		});

		

		if(state.category1Id!=0){
			productCategories.push(
				jsx('
				<ListItem button onClick=$goBack key={0} style=${{backgroundColor:CGColors.Bg1}}>
					<ListItemIcon>
						${CagetteTheme.getIcon("chevron-left")}
					</ListItemIcon>
					<ListItemText primary="Retour" />
				</ListItem>
				')
			);

		}
		
		var path = getPath();
		var pathElement = path=="" ? null : jsx('<div style=${{backgroundColor:CGColors.Bg1,padding:12,fontWeight:"bold"}}>$path</div>');

		return jsx('<div>
				$pathElement		   
			<List>
				$productCategories
			</List>                              
		</div>');
	
	}

	function goBack(_){
			
		if(state.category3Id!=0) {
			this.setState({category3Id:0});
		} else if (state.category2Id!=0){
			this.setState({category2Id:0});
		} else {
			this.setState({category1Id:0});
		}
	}	

	
}	

