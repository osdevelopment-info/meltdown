bits 64

section .bss
    cpu_vendor: resb 1       ; storage for the vendor: Intel (0x00)/AMD (0x01)/unknown (0xff)
    cpu_family: resb 1       ; storage for the processor family
    scratch:    resb 4096
    output:     resb 65536

section .data
    svendor:              db "vendor_id: "
    len_vendor:           equ $-svendor
    smax_cpuid:           db "Max Basic CPUID value: "
    slen_max_cpuid:       equ $-smax_cpuid
    sfamily:              db "cpu family: 0x"
    slen_family:          equ $-sfamily
    smodel:               db "cpu model: 0x"
    slen_model:           equ $-smodel
    sstepping:            db "stepping: 0x"
    slen_stepping:        equ $-sstepping
    sfeatures:            db "features:"
    slen_features:        equ $-sfeatures
    sfeat_fpu:            db " fpu"
    slen_feat_fpu:        equ $-sfeat_fpu
    sfeat_vme:            db " vme"
    slen_feat_vme:        equ $-sfeat_vme
    sfeat_de:             db " de"
    slen_feat_de:         equ $-sfeat_de
    sfeat_pse:            db " pse"
    slen_feat_pse:        equ $-sfeat_pse
    sfeat_tsc:            db " tsc"
    slen_feat_tsc:        equ $-sfeat_tsc
    sfeat_msr:            db " msr"
    slen_feat_msr:        equ $-sfeat_msr
    sfeat_pae:            db " pae"
    slen_feat_pae:        equ $-sfeat_pae
    sfeat_mce:            db " mce"
    slen_feat_mce:        equ $-sfeat_mce
    sfeat_cx8:            db " cx8"
    slen_feat_cx8:        equ $-sfeat_cx8
    sfeat_apic:           db " apic"
    slen_feat_apic:       equ $-sfeat_apic
    sfeat_sep:            db " sep"
    slen_feat_sep:        equ $-sfeat_sep
    sfeat_mtrr:           db " mtrr"
    slen_feat_mtrr:       equ $-sfeat_mtrr
    sfeat_pge:            db " pge"
    slen_feat_pge:        equ $-sfeat_pge
    sfeat_mca:            db " mca"
    slen_feat_mca:        equ $-sfeat_mca
    sfeat_cmov:           db " cmov"
    slen_feat_cmov:       equ $-sfeat_cmov
    sfeat_pat:            db " pat"
    slen_feat_pat:        equ $-sfeat_pat
    sfeat_pse36:          db " pse-36"
    slen_feat_pse36:      equ $-sfeat_pse36
    sfeat_psn:            db " psn"
    slen_feat_psn:        equ $-sfeat_psn
    sfeat_clfsh:          db " clfsh"
    slen_feat_clfsh:      equ $-sfeat_clfsh
    sfeat_ds:             db " ds"
    slen_feat_ds:         equ $-sfeat_ds
    sfeat_acpi:           db " acpi"
    slen_feat_acpi:       equ $-sfeat_acpi
    sfeat_mmx:            db " mmx"
    slen_feat_mmx:        equ $-sfeat_mmx
    sfeat_fxsr:           db " fxsr"
    slen_feat_fxsr:       equ $-sfeat_fxsr
    sfeat_sse:            db " sse"
    slen_feat_sse:        equ $-sfeat_sse
    sfeat_sse2:           db " sse2"
    slen_feat_sse2:       equ $-sfeat_sse2
    sfeat_ss:             db " ss"
    slen_feat_ss:         equ $-sfeat_ss
    sfeat_htt:            db " htt"
    slen_feat_htt:        equ $-sfeat_htt
    sfeat_tm:             db " tm"
    slen_feat_tm:         equ $-sfeat_tm
    sfeat_pbe:            db " pbe"
    slen_feat_pbe:        equ $-sfeat_pbe
    sfeat_sse3:           db " sse3"
    slen_feat_sse3:       equ $-sfeat_sse3
    sfeat_pclmulqdq:      db " pclmulqdq"
    slen_feat_pclmulqdq:  equ $-sfeat_pclmulqdq
    sfeat_dtes64:         db " dtes64"
    slen_feat_dtes64:     equ $-sfeat_dtes64
    sfeat_monitor:        db " monitor"
    slen_feat_monitor:    equ $-sfeat_monitor
    sfeat_dscpl:          db " ds-cpl"
    slen_feat_dscpl:      equ $-sfeat_dscpl
    sfeat_vmx:            db " vmx"
    slen_feat_vmx:        equ $-sfeat_vmx
    sfeat_smx:            db " smx"
    slen_feat_smx:        equ $-sfeat_smx
    sfeat_eist:           db " eist"
    slen_feat_eist:       equ $-sfeat_eist
    sfeat_tm2:            db " tm2"
    slen_feat_tm2:        equ $-sfeat_tm2
    sfeat_ssse3:          db " ssse3"
    slen_feat_ssse3:      equ $-sfeat_ssse3
    sfeat_cnxtid:         db " cnxt-id"
    slen_feat_cnxtid:     equ $-sfeat_cnxtid
    sfeat_sdbg:           db " sdbg"
    slen_feat_sdbg:       equ $-sfeat_sdbg
    sfeat_fma:            db " fma"
    slen_feat_fma:        equ $-sfeat_fma
    sfeat_cmpxchg16b:     db " cmpxchg16b"
    slen_feat_cmpxchg16b: equ $-sfeat_cmpxchg16b
    sfeat_xtpr:           db " xtpr"
    slen_feat_xtpr:       equ $-sfeat_xtpr
    sfeat_pdcm:           db " pscm"
    slen_feat_pdcm:       equ $-sfeat_pdcm
    sfeat_pcid:           db " pcid"
    slen_feat_pcid:       equ $-sfeat_pcid
    sfeat_dca:            db " dca"
    slen_feat_dca:        equ $-sfeat_dca
    sfeat_sse41:          db " sse4.1"
    slen_feat_sse41:      equ $-sfeat_sse41
    sfeat_sse42:          db " sse4.2"
    slen_feat_sse42:      equ $-sfeat_sse42
    sfeat_x2apic:         db " x2apic"
    slen_feat_x2apic:     equ $-sfeat_x2apic
    sfeat_movbe:          db " movbe"
    slen_feat_movbe:      equ $-sfeat_movbe
    scr:                  db 0xa

section .text
    extern printqw
    extern printdw
    extern printw
    extern printb
    extern printhqw
    extern printhdw
    extern printhw
    extern printhb
    global _start

; Scratch registers (for the complete programm)
; R12 maximum Basic CPUID Information
; R15 short term storage
_start:
    xor   RAX,RAX            ; clear RAX
    cpuid                    ; get cpu information 0x00 (Basic CPUID Information)
    mov   R8,RAX             ; save the maximal for Basic CPUID Information

    mov   RSI,svendor
    mov   RDI,output
    mov   R15,RCX
    mov   RCX,len_vendor
    rep
    movsb

    mov   RCX,R15
    mov   [RDI],EBX          ; copy vendor information to reserved string 
    mov   [RDI+4],EDX
    mov   [RDI+8],ECX
    add   RDI,12
    mov   RSI,scr
    movsb

    cmp   EBX,"Genu"
    je    vendor_intel
    cmp   EBX,"Auth"
    je    vendor_amd
    mov   [cpu_vendor],byte 0xff
    jmp   vendor_done
vendor_amd:
    mov   [cpu_vendor],byte 0x01
    jmp   vendor_done
vendor_intel:
    mov   [cpu_vendor],byte 0x00
vendor_done:

    mov   RSI,smax_cpuid
    mov   RCX,slen_max_cpuid
    rep
    movsb

    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    call  printdw            ; print the max number of Basic CPUID Information

    mov   RSI,scr
    movsb

    cmp   [cpu_vendor],byte 0x00 ; this is an Intel CPU
    je    known_vendor
    cmp   [cpu_vendor],byte 0x01 ; this is an AMD CPU
    je    known_vendor
    jmp   unknown_vendor

known_vendor:
    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    cmp   EAX,1              ; check if node 1 is supported by CPUID
    jl    done_basic         ; if 1 is not supported we're done

    mov   EAX,1              ; get the next node
    cpuid                    ; get cpu information 0x01 (Family/Model)
    mov   R9,RAX             ; save the model and family
    mov   R10,RBX            ; save the additional information
    mov   R12,RCX            ; save the features (part 2)
    mov   R13,RDX            ; save the features (part 1)
    shr   EAX,8              ; get bit 8 (lsb of family) to bit 0
    and   EAX,0x0f           ; mask the bits of the family
    mov   [cpu_family],AL    ; save the family
    cmp   EAX,0x0f           ; test if the family is a special value (0x0f)
    jne   simple_family      ; if not go directly to the output
    mov   RAX,R9             ; restore family information
    shr   EAX,20             ; get the extended family information
    and   EAX,0xff           ; mask the extended family information
    add   EAX,0x0f           ; add the family

simple_family:
    mov   RSI,sfamily        ; copy the family string
    mov   RCX,slen_family
    rep
    movsb
    call  printhw            ; print out the family

    mov   RSI,scr            ; append CR
    movsb

    cmp   [cpu_vendor],byte 0x00 ; this is an Intel CPU
    je    intel_model
    cmp   [cpu_vendor],byte 0x01 ; this is an AMD CPU
    je    amd_model
    jmp   unknown_vendor

intel_model:
    mov   RAX,R9             ; restore model information
    shr   EAX,4              ; get bit 4 (lsb of model) to bit 0
    and   EAX,0x0f           ; mask the bits of the model
    mov   BL,[cpu_family]    ; get the family information back
    cmp   BL,0x06            ; test if we need extended model information (0x06 or 0x0f)
    je    extended_intel_model
    cmp   BL,0x0f
    jne   simple_model
extended_intel_model:
    mov   RBX,R9             ; restore model information
    shr   EBX,12             ; get the extended model information to the high nibble
    and   EBX,0xf0
    or    EAX,EBX            ; add the model information to the low nibble
    jmp   simple_model
amd_model:
    mov   RAX,R9             ; restore model information
    shr   EAX,4              ; get bit 4 (lsb of model) to bit 0
    and   EAX,0x0f           ; mask the bits of the model
    mov   BL,[cpu_family]    ; get the family information back
    cmp   BL,0x0f
    jne   simple_model
    mov   RBX,R9             ; restore model information
    shr   EBX,12             ; get the extended model information to the high nibble
    and   EBX,0xf0
    or    EAX,EBX            ; add the model information to the low nibble

simple_model:
    mov   RSI,smodel
    mov   RCX,slen_model
    rep
    movsb
    call  printhw            ; print out the model
    mov   RSI,scr            ; append CR
    movsb

    mov   RAX,R9             ; restore stepping information
    and   EAX,0x0f           ; mask the stepping information

    mov   RSI,sstepping
    mov   RCX,slen_stepping
    rep
    movsb
    call  printhb            ; print out the model
    mov   RSI,scr            ; append CR
    movsb

    mov   RSI,sfeatures
    mov   RCX,slen_features
    rep
    movsb

    call  handle_features1
    call  handle_features2

    mov   RSI,scr            ; append CR
    movsb

    mov   RDX,RDI            ; calculate the length of the output
    sub   RDX,output
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,output
    syscall


unknown_vendor:
done_basic:

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall

handle_features1:
    bt    R13,0              ; test for fpu
    jnc   no_fpu
    mov   RSI,sfeat_fpu
    mov   RCX,slen_feat_fpu
    rep
    movsb
no_fpu:
    bt    R13,1              ; test for vme
    jnc   no_vme
    mov   RSI,sfeat_vme
    mov   RCX,slen_feat_vme
    rep
    movsb
no_vme:
    bt    R13,2              ; test for de
    jnc   no_de
    mov   RSI,sfeat_de
    mov   RCX,slen_feat_de
    rep
    movsb
no_de:
    bt    R13,3              ; test for pse
    jnc   no_pse
    mov   RSI,sfeat_pse
    mov   RCX,slen_feat_pse
    rep
    movsb
no_pse:
    bt    R13,4              ; test for tsc
    jnc   no_tsc
    mov   RSI,sfeat_tsc
    mov   RCX,slen_feat_tsc
    rep
    movsb
no_tsc:
    bt    R13,5              ; test for msr
    jnc   no_msr
    mov   RSI,sfeat_msr
    mov   RCX,slen_feat_msr
    rep
    movsb
no_msr:
    bt    R13,6              ; test for pae
    jnc   no_pae
    mov   RSI,sfeat_pae
    mov   RCX,slen_feat_pae
    rep
    movsb
no_pae:
    bt    R13,7              ; test for mce
    jnc   no_mce
    mov   RSI,sfeat_mce
    mov   RCX,slen_feat_mce
    rep
    movsb
no_mce:
    bt    R13,8              ; test for cx8
    jnc   no_cx8
    mov   RSI,sfeat_cx8
    mov   RCX,slen_feat_cx8
    rep
    movsb
no_cx8:
    bt    R13,9              ; test for apic
    jnc   no_apic
    mov   RSI,sfeat_apic
    mov   RCX,slen_feat_apic
    rep
    movsb
no_apic:
    bt    R13,11             ; test for sep
    jnc   no_sep
    mov   RSI,sfeat_sep
    mov   RCX,slen_feat_sep
    rep
    movsb
no_sep:
    bt    R13,12             ; test for mtrr
    jnc   no_mtrr
    mov   RSI,sfeat_mtrr
    mov   RCX,slen_feat_mtrr
    rep
    movsb
no_mtrr:
    bt    R13,13             ; test for pge
    jnc   no_pge
    mov   RSI,sfeat_pge
    mov   RCX,slen_feat_pge
    rep
    movsb
no_pge:
    bt    R13,14             ; test for mca
    jnc   no_mca
    mov   RSI,sfeat_mca
    mov   RCX,slen_feat_mca
    rep
    movsb
no_mca:
    bt    R13,15             ; test for cmov
    jnc   no_cmov
    mov   RSI,sfeat_cmov
    mov   RCX,slen_feat_cmov
    rep
    movsb
no_cmov:
    bt    R13,16             ; test for pat
    jnc   no_pat
    mov   RSI,sfeat_pat
    mov   RCX,slen_feat_pat
    rep
    movsb
no_pat:
    bt    R13,17             ; test for pse-36
    jnc   no_pse36
    mov   RSI,sfeat_pse36
    mov   RCX,slen_feat_pse36
    rep
    movsb
no_pse36:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_psn
    bt    R13,18             ; test for psn
    jnc   no_psn
    mov   RSI,sfeat_psn
    mov   RCX,slen_feat_psn
    rep
    movsb
no_psn:
    bt    R13,19             ; test for clfsh
    jnc   no_clfsh
    mov   RSI,sfeat_clfsh
    mov   RCX,slen_feat_clfsh
    rep
    movsb
no_clfsh:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_ds
    bt    R13,21             ; test for ds
    jnc   no_ds
    mov   RSI,sfeat_ds
    mov   RCX,slen_feat_ds
    rep
    movsb
no_ds:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_acpi
    bt    R13,22             ; test for acpi
    jnc   no_acpi
    mov   RSI,sfeat_acpi
    mov   RCX,slen_feat_acpi
    rep
    movsb
no_acpi:
    bt    R13,23             ; test for mmx
    jnc   no_mmx
    mov   RSI,sfeat_mmx
    mov   RCX,slen_feat_mmx
    rep
    movsb
no_mmx:
    bt    R13,24             ; test for fxsr
    jnc   no_fxsr
    mov   RSI,sfeat_fxsr
    mov   RCX,slen_feat_fxsr
    rep
    movsb
no_fxsr:
    bt    R13,25             ; test for sse
    jnc   no_sse
    mov   RSI,sfeat_sse
    mov   RCX,slen_feat_sse
    rep
    movsb
no_sse:
    bt    R13,26             ; test for sse2
    jnc   no_sse2
    mov   RSI,sfeat_sse2
    mov   RCX,slen_feat_sse2
    rep
    movsb
no_sse2:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_ss
    bt    R13,27             ; test for ss
    jnc   no_ss
    mov   RSI,sfeat_ss
    mov   RCX,slen_feat_ss
    rep
    movsb
no_ss:
    bt    R13,28             ; test for htt
    jnc   no_htt
    mov   RSI,sfeat_htt
    mov   RCX,slen_feat_htt
    rep
    movsb
no_htt:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_tm
    bt    R13,29             ; test for tm
    jnc   no_tm
    mov   RSI,sfeat_tm
    mov   RCX,slen_feat_tm
    rep
    movsb
no_tm:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_pbe
    bt    R13,31             ; test for pbe
    jnc   no_pbe
    mov   RSI,sfeat_pbe
    mov   RCX,slen_feat_pbe
    rep
    movsb
no_pbe:
    ret

handle_features2:
	bt    R12,0              ; test for sse3
    jnc   no_sse3
    mov   RSI,sfeat_sse3
    mov   RCX,slen_feat_sse3
    rep
    movsb
no_sse3:
	bt    R12,1              ; test for pclmulqdq
    jnc   no_pclmulqdq
    mov   RSI,sfeat_pclmulqdq
    mov   RCX,slen_feat_pclmulqdq
    rep
    movsb
no_pclmulqdq:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_dtes64
    bt    R12,2              ; test for dtes64
    jnc   no_dtes64
    mov   RSI,sfeat_dtes64
    mov   RCX,slen_feat_dtes64
    rep
    movsb
no_dtes64:
	bt    R12,3              ; test for monitor
    jnc   no_monitor
    mov   RSI,sfeat_monitor
    mov   RCX,slen_feat_monitor
    rep
    movsb
no_monitor:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_dscpl
    bt    R12,4              ; test for dscpl
    jnc   no_dscpl
    mov   RSI,sfeat_dscpl
    mov   RCX,slen_feat_dscpl
    rep
    movsb
no_dscpl:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_vmx
    bt    R12,5              ; test for vmx
    jnc   no_vmx
    mov   RSI,sfeat_vmx
    mov   RCX,slen_feat_vmx
    rep
    movsb
no_vmx:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_smx
    bt    R12,6              ; test for smx
    jnc   no_smx
    mov   RSI,sfeat_smx
    mov   RCX,slen_feat_smx
    rep
    movsb
no_smx:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_eist
    bt    R12,7              ; test for eist
    jnc   no_eist
    mov   RSI,sfeat_eist
    mov   RCX,slen_feat_eist
    rep
    movsb
no_eist:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_tm2
    bt    R12,8              ; test for tm2
    jnc   no_tm2
    mov   RSI,sfeat_tm2
    mov   RCX,slen_feat_tm2
    rep
    movsb
no_tm2:
	bt    R12,9              ; test for ssse3
    jnc   no_ssse3
    mov   RSI,sfeat_ssse3
    mov   RCX,slen_feat_ssse3
    rep
    movsb
no_ssse3:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_cnxtid
	bt    R12,10             ; test for cnxtid
    jnc   no_cnxtid
    mov   RSI,sfeat_cnxtid
    mov   RCX,slen_feat_cnxtid
    rep
    movsb
no_cnxtid:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_sdbg
	bt    R12,11             ; test for sdbg
    jnc   no_sdbg
    mov   RSI,sfeat_sdbg
    mov   RCX,slen_feat_sdbg
    rep
    movsb
no_sdbg:
	bt    R12,12             ; test for fma
    jnc   no_fma
    mov   RSI,sfeat_fma
    mov   RCX,slen_feat_fma
    rep
    movsb
no_fma:
	bt    R12,13             ; test for cmpxchg16b
    jnc   no_cmpxchg16b
    mov   RSI,sfeat_cmpxchg16b
    mov   RCX,slen_feat_cmpxchg16b
    rep
    movsb
no_cmpxchg16b:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_xtpr
	bt    R12,14             ; test for xtpr
    jnc   no_xtpr
    mov   RSI,sfeat_xtpr
    mov   RCX,slen_feat_xtpr
    rep
    movsb
no_xtpr:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_pdcm
	bt    R12,15             ; test for pdcm
    jnc   no_pdcm
    mov   RSI,sfeat_pdcm
    mov   RCX,slen_feat_pdcm
    rep
    movsb
no_pdcm:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_pcid
	bt    R12,17             ; test for pcid
    jnc   no_pcid
    mov   RSI,sfeat_pcid
    mov   RCX,slen_feat_pcid
    rep
    movsb
no_pcid:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_dca
	bt    R12,18             ; test for dca
    jnc   no_dca
    mov   RSI,sfeat_dca
    mov   RCX,slen_feat_dca
    rep
    movsb
no_dca:
	bt    R12,19             ; test for sse4.1
    jnc   no_sse41
    mov   RSI,sfeat_sse41
    mov   RCX,slen_feat_sse41
    rep
    movsb
no_sse41:
	bt    R12,20             ; test for sse4.2
    jnc   no_sse42
    mov   RSI,sfeat_sse42
    mov   RCX,slen_feat_sse42
    rep
    movsb
no_sse42:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_x2apic
	bt    R12,21             ; test for x2apic
    jnc   no_x2apic
    mov   RSI,sfeat_x2apic
    mov   RCX,slen_feat_x2apic
    rep
    movsb
no_x2apic:
	bt    R12,22             ; test for movbe
    jnc   no_movbe
    mov   RSI,sfeat_movbe
    mov   RCX,slen_feat_movbe
    rep
    movsb
no_movbe:
    ret
