package react.vendor;

import mui.core.grid.GridSpacing;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;
import mui.core.Typography;
import react.mui.CagetteTheme;
import mui.core.Avatar;
import mui.core.Button;
import mui.core.Card;
import mui.core.CardContent;
import mui.core.CardActionArea;
import mui.core.CardActions;
import mui.core.Grid;
import mui.core.GridList;
import mui.core.GridListTile;
import mui.core.GridListTileBar;
import mui.core.Link;
import mui.core.ListSubheader;
import react.vendor.SimpleMap;
import react.mui.Footer;
using Lambda;

class VendorPage extends react.ReactComponentOfProps<{vendorInfo: VendorInfos, catalogProducts: Array<ProductInfo>, nextDistributions: Array<DistributionInfos>}>{

	public function new(props){
		super(props);

		//default values
		if(props.vendorInfo.images.banner==null) {
			props.vendorInfo.images.banner = "/img/default-banner.jpg";
		}
		if(props.vendorInfo.images.portrait==null) {
			props.vendorInfo.images.portrait = props.vendorInfo.image;
		}

		if(props.vendorInfo.longDesc==null) {
			var desc = props.vendorInfo.desc==null ? "" : props.vendorInfo.desc;
			props.vendorInfo.longDesc = desc.split("\n").join("<br/>");
		}
	}

	override public function render(){

		return jsx('<>
		
		<div style=${{backgroundImage: 'url("${props.vendorInfo.images.banner}")', backgroundSize: "cover", backgroundRepeat: "no-repeat", backgroundPosition: "center", position: "relative", width: "100%", height: "250px"}}></div>
		
		<Grid container spacing=${GridSpacing.Spacing_0} direction=${Row} justify=${Center} style=${{maxWidth:"1240px",marginLeft:"auto",marginRight:"auto"}}>
			
			<Grid item xs={12} style=${{textAlign:"center"}}>

				<Avatar style=${{width:"160px", height:"160px", marginLeft: "auto", marginRight: "auto", marginTop: "-90px",border:"4px solid #FFF"}} src=${props.vendorInfo.images.portrait} />
			
				<h1>${props.vendorInfo.name}</h1>
				
				${getProfession()}

				<Typography component="p" style=${{fontSize:"1.1rem",color:CGColors.MediumGrey}}>
					${CagetteTheme.getIcon("map-marker")} ${props.vendorInfo.city} (${props.vendorInfo.zipCode})
				</Typography>

				${getHomepage()}
			
        	</Grid>

			<Typography component="div" style=${{fontSize:"1rem",margin:24}}>
				<ExpandableText text=${props.vendorInfo.longDesc} height=${280} />
			</Typography>
			

			${getProductExcerpt()}

			${getMap()}

			${getOffCagette()}
			
			${getPhotos()}

			${getCatalog()}

		</Grid>
		<Footer /></>');
	}

	function getProfession(){

		return props.vendorInfo.profession==null ? null : jsx('<Typography component="p" style=${{fontSize:"1.1rem",color:CGColors.MediumGrey}}>
			${props.vendorInfo.profession}
		</Typography>');
	}

	function getHomepage(){
		var v = props.vendorInfo;
		if(v.linkUrl==null) return null;
		
		return jsx('<Typography component="p" style=${{fontSize:"1.1rem",color:CGColors.MediumGrey}}>
			${CagetteTheme.getIcon("link")}&nbsp;&nbsp;
			<a href=${v.linkUrl} target="_blank">
				${(v.linkText==null) ? v.linkUrl : v.linkText }
			</a>
		</Typography>');
	}

	function getMap(){

		var distribs = [];
		for( d in props.nextDistributions){
			if(d.place.latitude!=null) distribs.push(d);
		}

		if(distribs==null || distribs.length==0) return null;

		var distributionMarkers: Array<MarkerInfo> = Lambda.array(Lambda.map(distribs,function(distrib) return { 
			key: Std.string(distrib.id),
			latitude: distrib.place.latitude,
			longitude: distrib.place.longitude,
			content: '<div><a href=${"/group/" + distrib.groupId} target="_blank">${distrib.groupName}</a></div>'
		} ));

		return jsx('<>
			<Grid item xs={12}>${ CagetteTheme.h2("Prochaines livraisons")}</Grid>
			<Grid item xs={12} sm={4} style=${{height: "500px", overflowY: Scroll, overflowX: Hidden}}>
				
			${distribs.map(function(distribution:DistributionInfos) {
			var startDate = Date.fromTime(distribution.distributionStartDate);					
			return jsx('
				<Card key=${distribution.id} style={{margin:8}}>
					<CardContent>
						<Grid container>
							<Grid item xs={4}>
								<div className="dateBox">
									<div className="box">
										<div>${Formatting.dayOfWeek(startDate)}</div>
										<div style=${{fontSize:28,color:"#990000"}}>${startDate.getDate()}</div>
										<div>${Formatting.month(startDate)}</div>				
									</div>
								</div>
							</Grid>

							<Grid item xs={8}>
								<Typography component="p" style=${{color:CGColors.MediumGrey}} >
									<b>${distribution.groupName}</b>
									<br/>
									${CagetteTheme.place(distribution.place)}
								</Typography>
							</Grid>
						</Grid>

						<Typography component="p" style=${{marginTop:12}}>
							Commande ouverte du ${Formatting.hDate(Date.fromTime(distribution.orderStartDate))}<br />
							au ${Formatting.hDate(Date.fromTime(distribution.orderEndDate))}
						</Typography>

					</CardContent>

					<CardActions>
						<Button onClick=${function(){js.Browser.window.open("/group/" + distribution.groupId,"_blank");}} size=$Medium color=$Primary variant=$Contained>
							Commander
						</Button>
					</CardActions>
				</Card>');})}			
			</Grid>

			<Grid item xs={12} sm={8} className="distributions-map">
				<SimpleMap markers=${distributionMarkers} />
			</Grid>
		</>');
	}

	function getProductExcerpt(){

		if(props.catalogProducts==null || props.catalogProducts.length==0) return null;
		//do not display excerpt if no map, otherwise we get the excerpt + after the whole catalog which is useless
		if(props.nextDistributions==null || props.nextDistributions.length==0) return null;

		var products = props.catalogProducts.slice(0,4).map(function(x){
			return jsx('<GridListTile key=${x.name} style=${{height:250}}>
				<img src=${x.image} />
				<GridListTileBar title=${x.name} />
			</GridListTile>');
		});

		var cols = if(products.length<4) products.length else 4;

		//if width under sm
		if(js.Browser.window.document.body.clientWidth<600) cols = 1;

		return jsx('<GridList cols=$cols>$products</GridList>');
	}

	

	function getOffCagette(){
		if(props.vendorInfo.offCagette==null) return null;
		return jsx('<Grid item xs={12}>
			<Typography style=${{fontSize:"1.3rem",margin:24,marginBottom:12}}>
				<span dangerouslySetInnerHTML=${{__html: "<b>Retrouvez nous aussi : </b>"+${props.vendorInfo.offCagette}}}></span>
			</Typography>
		</Grid>');
	}

	function getCatalog(){

		if(props.catalogProducts==null || props.catalogProducts.length==0) return null;
		var cols = if(props.catalogProducts.length<4) props.catalogProducts.length else 4;
		//if width under sm
		if(js.Browser.window.document.body.clientWidth<600) cols = 1;

		return jsx('<><Grid item xs={12}>
			${CagetteTheme.h2("Nos produits")}
		</Grid>

		<GridList cellHeight={250} cols=$cols>
			${props.catalogProducts.map(function(product:ProductInfo) {
				return jsx('<GridListTile key=${product.name} cols={1}>
					<img src=${product.image} alt=${product.name} />
					<GridListTileBar title=${product.name} />
				</GridListTile>');
			} )}
		</GridList></>');
	}

	function getPhotos(){
		if(props.vendorInfo.images.farm1==null) return null;
		return jsx('<>
		<Grid item xs={12}>
			${CagetteTheme.h2("L'exploitation")}
		</Grid>

		<GridList cellHeight={250} cols={4}>
			<GridListTile key={1}>
				<img src=${props.vendorInfo.images.farm1} />
			</GridListTile>
			<GridListTile key={2}>
				<img src=${props.vendorInfo.images.farm2} />
			</GridListTile>
			<GridListTile key={3}>
				<img src=${props.vendorInfo.images.farm3} />
			</GridListTile>
			<GridListTile key={4}>
				<img src=${props.vendorInfo.images.farm4} />
			</GridListTile>
		</GridList></>');

	}
}