package neo;

import react.ReactComponent.ReactComponentOfProps;

typedef GeoAutocompleteProps = {
    ?initialValue: String,
    ?label: String,
    ?noOptionsText: String,
    ?mapboxToken: String,
    onChange: Dynamic,
};

@:jsRequire('cagette-neo', 'GeoAutocomplete')
extern class GeoAutocomplete extends ReactComponentOfProps<GeoAutocompleteProps> {}