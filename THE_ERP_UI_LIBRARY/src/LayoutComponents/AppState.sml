(* AppState.sml: Application State Management
 * Provides centralized state management for the application
 * including user authentication state
 *)

structure AppState = struct
  (* Current logged-in username (NONE if not logged in) *)
  val currentUser = ref (NONE : string option)
  
  (* Sets the current user after successful login *)
  fun setCurrentUser username = 
    currentUser := SOME username
  
  (* Clears the current user on logout *)
  fun clearCurrentUser () = 
    currentUser := NONE
  
  (* Gets the current user *)
  fun getCurrentUser () = 
    !currentUser
  
  (* Checks if a user is logged in *)
  fun isLoggedIn () = 
    case !currentUser of
      SOME _ => true
    | NONE => false
end  