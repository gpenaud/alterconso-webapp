package react.store;
// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import Common;

using Lambda;

typedef MenuProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
}

private typedef TClasses = Classes<[

]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class Menu extends react.ReactComponentOfProps<MenuProps> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
           cagNavCategories : {

           },

           cagCategoryContainer : {

           },

           cagCategory : {

           },

		}
	}

	public function new(props) {
		super(props);
	}

	override public function render() {
		return jsx('
            <div class="cagNavCategories">
                <div class="cagWrap">
                    <Grid container spacing={0}>
                        <Grid item xs >
                            <div class="cagCategoryContainer cagCategoryActive">
                                <div class="cagCategory">
                                    <img src="/img/fruits-legumes.png" alt="Tous les produits"/>
                                    Tous les<br/> produits
                                </div>
                            </div>
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/fruits-legumes.png" alt="Fruits et légumes"/>
                                    Fruits et<br/> légumes
                                </div>
                            </div>
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/viande-charcuterie.png" alt="Viande et charcuterie"/>
                                    Viande et<br/> charcuterie
                                </div>
                            </div>                            
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/epicerie.png" alt="Épicerie"/>
                                    Épicerie salée<br/> et sucrée
                                </div>
                            </div>                       
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/cremerie.png" alt="Crémerie"/>
                                    Crémerie
                                </div>
                            </div>    
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/produits-mer.png" alt="Produits de la mer"/>
                                    Produits <br/>de la mer
                                </div>
                            </div> 
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/boulangerie-patisserie.png" alt="Boulangerie et pâtisserie "/>
                                    Boulangerie <br/>et pâtisserie 
                                </div>
                            </div> 
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer">
                                <div class="cagCategory">
                                    <img src="/img/desserts-plats-prepares.png" alt="Desserts et plats préparés"/>
                                    Desserts et<br/> plats préparés
                                </div>
                            </div> 
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer ">
                                <div class="cagCategory">
                                    <img src="/img/fruits-legumes.png" alt="Tous les produits"/>
                                    Boissons
                                </div>
                            </div>
                        </Grid>
                        <Grid item xs>
                            <div class="cagCategoryContainer ">
                                <div class="cagCategory">
                                    <img src="/img/fruits-legumes.png" alt="Tous les produits"/>
                                    Autres
                                </div>
                            </div>
                        </Grid>
                    </Grid>
                </div>
            </div>
        ');
    }
}


