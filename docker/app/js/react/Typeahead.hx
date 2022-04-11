package react;

/**
 * 
 * Use the 1.4.x version. The 2.x version is still buggy
 * 
 * @doc https://www.npmjs.com/package/react-bootstrap-typeahead
 */
@:jsRequire('react-bootstrap-typeahead', 'Typeahead')
extern class Typeahead extends react.ReactComponent{}

/**
 * @doc https://github.com/ericgio/react-bootstrap-typeahead/blob/803f61c1c8d0c943106233ed3c9306acc19b5b2b/docs/API.md#asynctypeahead
 * Async component is needed when options and searches are managed asynchronously
 */
@:jsRequire('react-bootstrap-typeahead', 'AsyncTypeahead')
extern class AsyncTypeahead extends react.ReactComponent{}