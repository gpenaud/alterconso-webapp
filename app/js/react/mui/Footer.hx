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
					<a href="http://www.cagette.net" target="_blank">
						<img src="/img/logo.png" alt="Cagette.net"/>
					</a>  
				</Grid>

				<Grid item md={3} xs={12} style=${{textAlign:"left"}}>
					AIDE
					<ul>
						<li> 
							<a href="http://www.cagette.net/wiki" target="_blank">Documentation</a> 
						</li>
						<li>
							<a href="https://www.facebook.com/groups/EntraideCagette/" target="_blank">Groupe Facebook</a> 
						</li>
						<li>
							<a href="https://www.cagette.pro" target="_blank">Formations pour producteurs</a> 
						</li>
					</ul>					
				</Grid>

				<Grid item md={3} xs={12} style=${{textAlign:"left"}}>
					CONTACTEZ-NOUS
					<ul>
						<li>
							 <a href="https://cagette.uservoice.com" target="_blank">Proposer une amélioration</a>  
						</li>
					</ul>
				</Grid>

				<Grid item md={3} xs={12} style=${{textAlign:"right"}}>
					SUIVEZ-NOUS
					<ul className="cagsocialmedia" style=${{textAlign:"right"}}>
						<li className="cagfb">
							<a title="Facebook" href="https://www.facebook.com/cagette" target="_blank">
                                <i className="icon icon-facebook"></i>
                            </a>	
						</li>
						<li className="cagtwitter">
							<a title="Twitter" href="https://twitter.com/Cagettenet" target="_blank">
                                <i className="icon icon-twitter"></i>
                            </a> 
						</li>
						<li className="cagyoutube">
							<a title="Youtube" href="https://www.youtube.com/channel/UC3cvGxAUrbN9oSZmr1oZEaw" target="_blank">
                                <i className="icon icon-youtube"></i>
                            </a> 						
						</li>
						<li className="caggithub">
							<a title="Github" href="https://github.com/bablukid/cagette" target="_blank">
                                <i className="icon icon-github"></i>
                            </a> 						
						</li>
					</ul>
				</Grid>
            </Grid>
			</div>
		');
	}
}