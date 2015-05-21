(* This code was written by Martin Lange as part of the CFGAnalyzer tool, *)
(* available at http://www2.tcs.ifi.lmu.de/~mlange/cfganalyzer/ *)
(* This version has been slightly modified by Jessica Sorrell for the *)
(* purposes of integrating the PicoSAT solver. *)

open Picosat;;
open Satwrapper;;

class picosatSolver _ =
let solver = picosat_InitManager () in
let _ = picosat_SetTimeLimit solver (60.0 *. 60.0 *. 24.0 *. 31.0) in
object inherit abstractSolver

	method dispose = picosat_ReleaseManager solver

	method add_variable = picosat_AddVariable solver

	method add_clause a = picosat_AddClause solver a 1

	method solve =
	  match picosat_Solve solver with
	    2 -> SolveSatisfiable
	  | 1 -> SolveUnsatisfiable
	  | i -> SolveFailure ("picosat reported " ^ string_of_int i ^ " instead of 10 / 20")

	method get_assignment v = picosat_GetVarAsgnment solver v = 1

	method incremental_reset = picosat_Reset solver

	method print_dimacs _ = failwith "unsupported method: picosat.print_dimacs"

        method set_timeout_limit = picosat_SetTimeLimit solver

        method get_new_clause_group_ID = picosat_AllocClauseGroupID solver 

        method add_clause_to_group a g =  picosat_AddClause solver a g

        method delete_clause_group = picosat_DeleteClauseGroup solver

        method get_number_clauses = picosat_NumClauses solver 

        method get_number_literals = picosat_NumLiterals solver

        method get_number_variables = picosat_NumVariables solver

end;;

class picosatSolverFactory =
object inherit solverFactory

	method description = "Picosat"
	method identifier = "picosat"
	method short_identifier = "ps"
	method copyright = "Copyright Princeton"
	method url = "http://www.princeton.edu/~chaff/picosat.html"

	method new_instance = new picosatSolver ()
end;;

Satsolvers.register_solver (new picosatSolverFactory)
