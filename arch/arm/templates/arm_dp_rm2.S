/* OOL handler for the ARM data processing instructions, where:
 *      rm == pc
 *      rd != pc
 *      rn != pc
 *      rn == rd or rd is not used
 */

#include "arm_handler.h"
HANDLER_BEGIN

tf_patch_cond:
    b ool_handler       /* condition is true, execute instruction OOL */
    ldr pc, tf_next_pc  /* condition is false, return to original code */

ool_handler:

tf_patch_rt2rs1:
    push { r3 }         /* push temporary register */

tf_patch_rt2rs2:
    ldr r3, tf_read_pc  /* load original pc value into temporary register */

tf_insn:
tf_patch_rm2rs:
    add r0, r0, r3      /* original instruction with rn replaced by rs */

tf_patch_rt2rs4:
    pop { r3 }          /* pop temporary register */

    ldr pc, tf_next_pc  /* return to original code */

HANDLER_CONSTANTS

tf_next_pc:
    .word BAD
tf_read_pc:
    .word BAD

HANDLER_END
