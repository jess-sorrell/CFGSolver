
/**
 *  This is a wrapper for picosat solver
 *
 */
#ifndef _PICOSAT_OCAML_WRAPPER_H_
#define _PICOSAT_OCAML_WRAPPER_H_

extern "C" {
#include "picosat.h"
}

#include <caml/mlvalues.h>

#ifdef __cplusplus
extern "C"
{
#endif

value picosat_InitManager(void);

value picosat_ReleaseManager(value mng);

value picosat_SetNumVariables(value mng, value num_vars);

value picosat_AddVariable(value mng);


value picosat_AddClause(value mng, value clause_lits, value gid);

value picosat_DeleteClauseGroup(value mng, value gid);

value picosat_Reset(value mng);



value picosat_AllocClauseGroupID(value mng);


value  picosat_SetTimeLimit(value mng, value runtime);

value picosat_GetVarAsgnment(value mng, value v_idx);


value picosat_NumLiterals(value mng);

value picosat_NumClauses(value mng);

value picosat_NumVariables(value mng);


#ifdef __cplusplus
}
#endif

#endif

