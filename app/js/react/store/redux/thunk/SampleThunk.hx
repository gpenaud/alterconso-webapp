package react.cagette.thunk;

import redux.Redux.Dispatch;

import react.cagette.state.State;
import react.cagette.action.CartAction;

class AppThunk {
	static public function initApp(cb:Void->Void) {

		return redux.thunk.Thunk.Action(function(dispatch:Dispatch, getState:Void->State) {
			//return dispatch(AnAction("blabla"));
		});
	}
}

