package react.mui;

import react.ReactComponent;

typedef BoxProps = {
    ?display: String,
    ?justifyContent: String,
    ?alignItems: String,
    ?width: Dynamic,
    ?height: Dynamic,
    ?m: Int,
    ?mx: Int,
    ?my: Int,
    ?mt: Int,
    ?mb: Int,
    ?ml: Int,
    ?mr: Int,
    ?p: Int,
    ?px: Int,
    ?py: Int,
    ?pt: Int,
    ?pb: Int,
    ?pl: Int,
    ?pr: Int,
    ?bgcolor: String,
    ?boxShadow: Int,
    ?component: Dynamic,
};

@:jsRequire('@material-ui/core', 'Box')
extern class Box extends react.ReactComponentOfProps<BoxProps> {}