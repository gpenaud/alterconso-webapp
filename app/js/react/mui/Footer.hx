package react.mui;
import mui.core.grid.GridSpacing;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;
import react.mui.CagetteTheme;
import mui.core.Grid;

class Footer extends react.ReactComponent
{
	override public function render(){

		return jsx('<div id="footer" style=${{width:"100%",backgroundColor:CGColors.Secondary,marginTop:32,paddingTop:24,paddingBottom:24,color:CGColors.White}}>
			<Grid container spacing=${GridSpacing.Spacing_0} direction=${Row} justify=${Center} style=${{maxWidth:"1240px",marginLeft:"auto",marginRight:"auto"}}>
        <Grid item md={3} xs={12} style=${{textAlign:"left"}}>
					<a href="https://alterconso.leportail.org" target="_blank">
						<img src="/img/logo.png" alt="Alterconso"/>
					</a>
				</Grid>

				<Grid item md={3} xs={12} style=${{textAlign:"left"}}>
					AIDE
					<ul>
						<li>
							<a href="https://github.com/gpenaud/cagette-webapp" target="_blank">Documentation</a>
						</li>
					</ul>
				</Grid>

				<Grid item md={3} xs={12} style=${{textAlign:"right"}}>
					CONTACTEZ-NOUS
					<ul>
						<li>
							 <a href="https://www.leportail.org" target="_blank">Ecolieu du portail</a>
						</li>
					</ul>
				</Grid>
			</Grid>
		</div>');
	}
}
