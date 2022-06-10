package react.product;
import react.ReactDOM;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

typedef ProductInputProps = {
	formName:String,
	txpProductId:Int,
	productName:String,
}

typedef ProductInputState = {
	txpProductId:Int,
	productName:String,
	categoryId:Int,
	breadcrumb:String,
	open:Bool,
	categories : Array<CategoryInfo>,//categories dico
}

/**
 * Product Text Input with autocompletion
 * 
 * @author fbarbut
 */
class ProductInput extends react.ReactComponentOfPropsAndState<ProductInputProps,ProductInputState> {
	//public static var DICO : TxpDictionnary = null;
	var options : Array<{id:Int,label:String}>;
	var imgRef: react.ReactRef<{src:String}>;

	public function new(props:ProductInputProps) {
		super(props);
		options = [];
		this.state = {
			txpProductId : props.txpProductId,
			productName : props.productName,
			categoryId : 0,
			breadcrumb : "",
			open:false,
			categories:[]
		};
		this.imgRef  = React.createRef();
	}
	
	override public function render(){
		var inputName :String = props.formName+"_name";
		var txpProductInputName :String = props.formName+"_txpProductId";
	
		var categoriesWidget = if(this.state.open) jsx('<CategorySelector categories=${state.categories} onSelect=$onSelect onClose=$onClose/>') else null;

		var breadcrumb = if( state.breadcrumb!="") jsx('<><i className="icon icon-tag" /> ${state.breadcrumb}<br/></>') else null;


		return jsx('
			<div className="row">
			
				<div className="col-md-8">
					<input className="form-control" type="text" name=$inputName value=${state.productName} onChange=$onChange/>									
					<div className = "txpProduct" >
						$breadcrumb
						<a href="#" className="btn btn-default btn-xs" onClick=$openCategorizeWidget>Catégoriser ce produit</a>
						$categoriesWidget	
					</div>									
					<input className="txpProduct" type="hidden" name=$txpProductInputName value=${state.txpProductId} />					
				</div>
				
				<div className="col-md-4">
					<img ref=${this.imgRef} className="img-thumbnail" />
				</div>

			</div>
		');
	}

	override function componentDidMount() {

		//Load categories from API
		var initRequest = utils.HttpUtil.fetch("/api/product/categories", GET, null, JSON).then(
			function(data:Dynamic) {
				var categories:Array<CategoryInfo> = data;

				//sort alphabetically subcategories
				for( c1 in categories){
					c1.subcategories.sort(function(a,b){
						return if(a.name>b.name) 1 else -1;
					});
					for(c2 in c1.subcategories){
						c2.subcategories.sort(function(a,b){
							return if(a.name>b.name) 1 else -1;
						});
					}
				}

				if(props.txpProductId==null){					
					this.setState({categories:categories});
				}else{
					this.setState({categories:categories},
					function(){
						///we already have a value
						var infos = getInfos(props.txpProductId);
						setState({open:false,breadcrumb:infos.breadcrumb,txpProductId:props.txpProductId});
						imgRef.current.src = infos.image;
					});
				}
			}		

		).catchError(
			function(error) {
				throw error;
			}
		);
	}	

	/**
		called when a categ is selected
	**/
	function onSelect(id:Int){

		var infos = getInfos(id);
		setState({open:false,breadcrumb:infos.breadcrumb,txpProductId:id});
		imgRef.current.src = infos.image;

	}

	function openCategorizeWidget(_){
		setState({open:true});
	}

	/**
		Get infos from a categ3 id
	**/
	function getInfos(id:Int) {

        var category1 = null;
        var category2 = null;
        var category3 = null;

		for( c1 in state.categories ){
			category1 = c1;
			for( c2 in c1.subcategories ){
				category2 = c2;
				for( c3 in c2.subcategories){
					category3 = c3;
					if(id==c3.id){
						return {
							breadcrumb:c1.name+" / "+c2.name+" / "+c3.name,
							image : c1.image
						}
					}
				}
			}
		}

		return null;

    }

	function onChange(event:js.html.Event) {
		this.setState({productName: untyped event.target.value});
		event.preventDefault();
	}

	function onClose(event:js.html.Event,reason:mui.core.modal.ModalCloseReason) {
		this.setState({open:false});
		event.preventDefault();
	}

	

	
}