bits 64

section .bss
    cpuinfo:    times 256 resd 6 ; Create storage for the info from the cpuid
    cpu_vendor: resb 1       ; storage for the vendor: Intel (0x00)/AMD (0x01)/unknown (0xff)
    cpu_family: resb 1       ; storage for the processor family
    scratch:    resb 4096
    output:     resb 131072

section .rodata
    svendor:                db "vendor id: "
    len_vendor:             equ $-svendor
    smax_cpuid:             db "cpu level: "
    slen_max_cpuid:         equ $-smax_cpuid
    sfamily:                db "cpu family: 0x"
    slen_family:            equ $-sfamily
    smodel:                 db "cpu model: 0x"
    slen_model:             equ $-smodel
    sstepping:              db "stepping: 0x"
    slen_stepping:          equ $-sstepping
    sfeatures:              db "features:"
    slen_features:          equ $-sfeatures
    sfeat_fpu:              db " fpu"
    slen_feat_fpu:          equ $-sfeat_fpu
    sfeat_vme:              db " vme"
    slen_feat_vme:          equ $-sfeat_vme
    sfeat_de:               db " de"
    slen_feat_de:           equ $-sfeat_de
    sfeat_pse:              db " pse"
    slen_feat_pse:          equ $-sfeat_pse
    sfeat_tsc:              db " tsc"
    slen_feat_tsc:          equ $-sfeat_tsc
    sfeat_msr:              db " msr"
    slen_feat_msr:          equ $-sfeat_msr
    sfeat_pae:              db " pae"
    slen_feat_pae:          equ $-sfeat_pae
    sfeat_mce:              db " mce"
    slen_feat_mce:          equ $-sfeat_mce
    sfeat_cx8:              db " cx8"
    slen_feat_cx8:          equ $-sfeat_cx8
    sfeat_apic:             db " apic"
    slen_feat_apic:         equ $-sfeat_apic
    sfeat_sep:              db " sep"
    slen_feat_sep:          equ $-sfeat_sep
    sfeat_mtrr:             db " mtrr"
    slen_feat_mtrr:         equ $-sfeat_mtrr
    sfeat_pge:              db " pge"
    slen_feat_pge:          equ $-sfeat_pge
    sfeat_mca:              db " mca"
    slen_feat_mca:          equ $-sfeat_mca
    sfeat_cmov:             db " cmov"
    slen_feat_cmov:         equ $-sfeat_cmov
    sfeat_pat:              db " pat"
    slen_feat_pat:          equ $-sfeat_pat
    sfeat_pse36:            db " pse-36"
    slen_feat_pse36:        equ $-sfeat_pse36
    sfeat_psn:              db " psn"
    slen_feat_psn:          equ $-sfeat_psn
    sfeat_clfsh:            db " clfsh"
    slen_feat_clfsh:        equ $-sfeat_clfsh
    sfeat_ds:               db " ds"
    slen_feat_ds:           equ $-sfeat_ds
    sfeat_acpi:             db " acpi"
    slen_feat_acpi:         equ $-sfeat_acpi
    sfeat_mmx:              db " mmx"
    slen_feat_mmx:          equ $-sfeat_mmx
    sfeat_fxsr:             db " fxsr"
    slen_feat_fxsr:         equ $-sfeat_fxsr
    sfeat_sse:              db " sse"
    slen_feat_sse:          equ $-sfeat_sse
    sfeat_sse2:             db " sse2"
    slen_feat_sse2:         equ $-sfeat_sse2
    sfeat_ss:               db " ss"
    slen_feat_ss:           equ $-sfeat_ss
    sfeat_htt:              db " htt"
    slen_feat_htt:          equ $-sfeat_htt
    sfeat_tm:               db " tm"
    slen_feat_tm:           equ $-sfeat_tm
    sfeat_pbe:              db " pbe"
    slen_feat_pbe:          equ $-sfeat_pbe
    sfeat_sse3:             db " sse3"
    slen_feat_sse3:         equ $-sfeat_sse3
    sfeat_pclmulqdq:        db " pclmulqdq"
    slen_feat_pclmulqdq:    equ $-sfeat_pclmulqdq
    sfeat_dtes64:           db " dtes64"
    slen_feat_dtes64:       equ $-sfeat_dtes64
    sfeat_monitor:          db " monitor"
    slen_feat_monitor:      equ $-sfeat_monitor
    sfeat_dscpl:            db " ds-cpl"
    slen_feat_dscpl:        equ $-sfeat_dscpl
    sfeat_vmx:              db " vmx"
    slen_feat_vmx:          equ $-sfeat_vmx
    sfeat_smx:              db " smx"
    slen_feat_smx:          equ $-sfeat_smx
    sfeat_eist:             db " eist"
    slen_feat_eist:         equ $-sfeat_eist
    sfeat_tm2:              db " tm2"
    slen_feat_tm2:          equ $-sfeat_tm2
    sfeat_ssse3:            db " ssse3"
    slen_feat_ssse3:        equ $-sfeat_ssse3
    sfeat_cnxtid:           db " cnxt-id"
    slen_feat_cnxtid:       equ $-sfeat_cnxtid
    sfeat_sdbg:             db " sdbg"
    slen_feat_sdbg:         equ $-sfeat_sdbg
    sfeat_fma:              db " fma"
    slen_feat_fma:          equ $-sfeat_fma
    sfeat_cmpxchg16b:       db " cmpxchg16b"
    slen_feat_cmpxchg16b:   equ $-sfeat_cmpxchg16b
    sfeat_xtpr:             db " xtpr"
    slen_feat_xtpr:         equ $-sfeat_xtpr
    sfeat_pdcm:             db " pscm"
    slen_feat_pdcm:         equ $-sfeat_pdcm
    sfeat_pcid:             db " pcid"
    slen_feat_pcid:         equ $-sfeat_pcid
    sfeat_dca:              db " dca"
    slen_feat_dca:          equ $-sfeat_dca
    sfeat_sse41:            db " sse4.1"
    slen_feat_sse41:        equ $-sfeat_sse41
    sfeat_sse42:            db " sse4.2"
    slen_feat_sse42:        equ $-sfeat_sse42
    sfeat_x2apic:           db " x2apic"
    slen_feat_x2apic:       equ $-sfeat_x2apic
    sfeat_movbe:            db " movbe"
    slen_feat_movbe:        equ $-sfeat_movbe
    sfeat_popcnt:           db " popcnt"
    slen_feat_popcnt:       equ $-sfeat_popcnt
    sfeat_tsc_deadline:     db " tsc-deadline"
    slen_feat_tsc_deadline: equ $-sfeat_tsc_deadline
    sfeat_aes:              db " aesni"
    slen_feat_aes:          equ $-sfeat_aes
    sfeat_xsave:            db " xsave"
    slen_feat_xsave:        equ $-sfeat_xsave
    sfeat_osxsave:          db " osxsave"
    slen_feat_osxsave:      equ $-sfeat_osxsave
    sfeat_avx:              db " avx"
    slen_feat_avx:          equ $-sfeat_avx
    sfeat_f16c:             db " f16c"
    slen_feat_f16c:         equ $-sfeat_f16c
    sfeat_rdrand:           db " rdrand"
    slen_feat_rdrand:       equ $-sfeat_rdrand
    scacheline:             db "cache line size: "
    len_cacheline:          equ $-scacheline
    scachetlb:              db "Cache/TLB information (EAX=0x02) (Intel):",0x0a
    len_scachetlb:          equ $-scachetlb
    scachetlb_00:           dw len_scachetlb_00
                            db ""
    len_scachetlb_00:       equ $-scachetlb_00
    scachetlb_01:           dw len_scachetlb_01
                            db "  Instruction TLB: 4 KByte pages, 4-way set associative, 32 entries",0x0a
    len_scachetlb_01:       equ $-scachetlb_01
    scachetlb_02:           dw len_scachetlb_02
                            db "  Instruction TLB: 4 MByte pages, fully associative, 2 entries",0x0a
    len_scachetlb_02:       equ $-scachetlb_02
    scachetlb_03:           dw len_scachetlb_03
                            db "  Data TLB: 4 KByte pages, 4-way set associative, 64 entries",0x0a
    len_scachetlb_03:       equ $-scachetlb_03
    scachetlb_04:           dw len_scachetlb_04
                            db "  Data TLB: 4 MByte pages, 4-way set associative, 8 entries",0x0a
    len_scachetlb_04:       equ $-scachetlb_04
    scachetlb_05:           dw len_scachetlb_05
                            db "  Data TLB1: 4 MByte pages, 4-way set associative, 32 entries",0x0a
    len_scachetlb_05:       equ $-scachetlb_05
    scachetlb_06:           dw len_scachetlb_06
                            db "  1st-level instruction cache: 8 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_06:       equ $-scachetlb_06
    scachetlb_08:           dw len_scachetlb_08
                            db "  1st-level instruction cache: 16 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_08:       equ $-scachetlb_08
    scachetlb_09:           dw len_scachetlb_09
                            db "  1st-level instruction cache: 32KBytes, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_09:       equ $-scachetlb_09
    scachetlb_0a:           dw len_scachetlb_0a
                            db "  1st-level data cache: 8 KBytes, 2-way set associative, 32 byte line size",0x0a
    len_scachetlb_0a:       equ $-scachetlb_0a
    scachetlb_0b:           dw len_scachetlb_0b
                            db "  Instruction TLB: 4 MByte pages, 4-way set associative, 4 entries",0x0a
    len_scachetlb_0b:       equ $-scachetlb_0b
    scachetlb_0c:           dw len_scachetlb_0c
                            db "  1st-level data cache: 16 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_0c:       equ $-scachetlb_0c
    scachetlb_0d:           dw len_scachetlb_0d
                            db "  1st-level data cache: 16 KBytes, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_0d:       equ $-scachetlb_0d
    scachetlb_0e:           dw len_scachetlb_0e
                            db "  1st-level data cache: 24 KBytes, 6-way set associative, 64 byte line size",0x0a
    len_scachetlb_0e:       equ $-scachetlb_0e
    scachetlb_1d:           dw len_scachetlb_1d
                            db "  2nd-level cache: 128 KBytes, 2-way set associative, 64 byte line size",0x0a
    len_scachetlb_1d:       equ $-scachetlb_1d
    scachetlb_21:           dw len_scachetlb_21
                            db "  2nd-level cache: 256 KBytes, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_21:       equ $-scachetlb_21
    scachetlb_22:           dw len_scachetlb_22
                            db "  3rd-level cache: 512 KBytes, 4-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_22:       equ $-scachetlb_22
    scachetlb_23:           dw len_scachetlb_23
                            db "  3rd-level cache: 1 MBytes, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_23:       equ $-scachetlb_23
    scachetlb_24:           dw len_scachetlb_24
                            db "  2nd-level cache: 1 MBytes, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_24:       equ $-scachetlb_24
    scachetlb_25:           dw len_scachetlb_25
                            db "  3rd-level cache: 2 MBytes, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_25:       equ $-scachetlb_25
    scachetlb_29:           dw len_scachetlb_29
                            db "  3rd-level cache: 4 MBytes, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_29:       equ $-scachetlb_29
    scachetlb_2c:           dw len_scachetlb_2c
                            db "  1st-level data cache: 32 KBytes, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_2c:       equ $-scachetlb_2c
    scachetlb_30:           dw len_scachetlb_30
                            db "  1st-level instruction cache: 32 KBytes, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_30:       equ $-scachetlb_30
    scachetlb_40:           dw len_scachetlb_40
                            db "  No 2nd-level cache or, if processor contains a valid 2nd-level cache, no 3rd-level cache",0x0a
    len_scachetlb_40:       equ $-scachetlb_40
    scachetlb_41:           dw len_scachetlb_41
                            db "  2nd-level cache: 128 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_41:       equ $-scachetlb_41
    scachetlb_42:           dw len_scachetlb_42
                            db "  2nd-level cache: 256 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_42:       equ $-scachetlb_42
    scachetlb_43:           dw len_scachetlb_43
                            db "  2nd-level cache: 512 KBytes, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_43:       equ $-scachetlb_43
    scachetlb_44:           dw len_scachetlb_44
                            db "  2nd-level cache: 1 MByte, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_44:       equ $-scachetlb_44
    scachetlb_45:           dw len_scachetlb_45
                            db "  2nd-level cache: 2 MByte, 4-way set associative, 32 byte line size",0x0a
    len_scachetlb_45:       equ $-scachetlb_45
    scachetlb_46:           dw len_scachetlb_46
                            db "  3rd-level cache: 4 MByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_46:       equ $-scachetlb_46
    scachetlb_47:           dw len_scachetlb_47
                            db "  3rd-level cache: 8 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_47:       equ $-scachetlb_47
    scachetlb_48:           dw len_scachetlb_48
                            db "  2nd-level cache: 3MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_48:       equ $-scachetlb_48
    scachetlb_49:           dw len_scachetlb_49
                            db "  2nd-level cache: 4 MByte, 16-way set associative, 64 byte line size (family 0x0f,model 0x06 -> 3rd-level cache)",0x0a
    len_scachetlb_49:       equ $-scachetlb_49
    scachetlb_4a:           dw len_scachetlb_4a
                            db "  3rd-level cache: 6MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_4a:       equ $-scachetlb_4a
    scachetlb_4b:           dw len_scachetlb_4b
                            db "  3rd-level cache: 8MByte, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_4b:       equ $-scachetlb_4b
    scachetlb_4c:           dw len_scachetlb_4c
                            db "  3rd-level cache: 12MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_4c:       equ $-scachetlb_4c
    scachetlb_4d:           dw len_scachetlb_4d
                            db "  3rd-level cache: 16MByte, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_4d:       equ $-scachetlb_4d
    scachetlb_4e:           dw len_scachetlb_4e
                            db "  2nd-level cache: 6MByte, 24-way set associative, 64 byte line size",0x0a
    len_scachetlb_4e:       equ $-scachetlb_4e
    scachetlb_4f:           dw len_scachetlb_4f
                            db "  Instruction TLB: 4 KByte pages, 32 entries",0x0a
    len_scachetlb_4f:       equ $-scachetlb_4f
    scachetlb_50:           dw len_scachetlb_50
                            db "  Instruction TLB: 4 KByte and 2-MByte or 4-MByte pages, 64 entries",0x0a
    len_scachetlb_50:       equ $-scachetlb_50
    scachetlb_51:           dw len_scachetlb_51
                            db "  Instruction TLB: 4 KByte and 2-MByte or 4-MByte pages, 128 entries",0x0a
    len_scachetlb_51:       equ $-scachetlb_51
    scachetlb_52:           dw len_scachetlb_52
                            db "  Instruction TLB: 4 KByte and 2-MByte or 4-MByte pages, 256 entries",0x0a
    len_scachetlb_52:       equ $-scachetlb_52
    scachetlb_55:           dw len_scachetlb_55
                            db "  Instruction TLB: 2-MByte or 4-MByte pages, fully associative, 7 entries",0x0a
    len_scachetlb_55:       equ $-scachetlb_55
    scachetlb_56:           dw len_scachetlb_56
                            db "  Data TLB0: 4 MByte pages, 4-way set associative, 16 entries",0x0a
    len_scachetlb_56:       equ $-scachetlb_56
    scachetlb_57:           dw len_scachetlb_57
                            db "  Data TLB0: 4 KByte pages, 4-way associative, 16 entries",0x0a
    len_scachetlb_57:       equ $-scachetlb_57
    scachetlb_59:           dw len_scachetlb_59
                            db "  Data TLB0: 4 KByte pages, fully associative, 16 entries",0x0a
    len_scachetlb_59:       equ $-scachetlb_59
    scachetlb_5a:           dw len_scachetlb_5a
                            db "  Data TLB0: 2 MByte or 4 MByte pages, 4-way set associative, 32 entries",0x0a
    len_scachetlb_5a:       equ $-scachetlb_5a
    scachetlb_5b:           dw len_scachetlb_5b
                            db "  Data TLB: 4 KByte and 4 MByte pages, 64 entries",0x0a
    len_scachetlb_5b:       equ $-scachetlb_5b
    scachetlb_5c:           dw len_scachetlb_5c
                            db "  Data TLB: 4 KByte and 4 MByte pages,128 entries",0x0a
    len_scachetlb_5c:       equ $-scachetlb_5c
    scachetlb_5d:           dw len_scachetlb_5d
                            db "  Data TLB: 4 KByte and 4 MByte pages,256 entries",0x0a
    len_scachetlb_5d:       equ $-scachetlb_5d
    scachetlb_60:           dw len_scachetlb_60
                            db "  1st-level data cache: 16 KByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_60:       equ $-scachetlb_60
    scachetlb_61:           dw len_scachetlb_61
                            db "  Instruction TLB: 4 KByte pages, fully associative, 48 entries",0x0a
    len_scachetlb_61:       equ $-scachetlb_61
    scachetlb_63:           dw len_scachetlb_63
                            db "  Data TLB: 2 MByte or 4 MByte pages, 4-way set associative, 32 entries and a separate arraypages, 4-way set associative, 4 entries with 1 GByte pages, 4-way set associative, 4 entries",0x0a
    len_scachetlb_63:       equ $-scachetlb_63
    scachetlb_64:           dw len_scachetlb_64
                            db "  Data TLB: 4 KByte pages, 4-way set associative, 512 entries",0x0a
    len_scachetlb_64:       equ $-scachetlb_64
    scachetlb_66:           dw len_scachetlb_66
                            db "  1st-level data cache: 8 KByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_66:       equ $-scachetlb_66
    scachetlb_67:           dw len_scachetlb_67
                            db "  1st-level data cache: 8 KByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_67:       equ $-scachetlb_67
    scachetlb_68:           dw len_scachetlb_68
                            db "  1st-level data cache: 32 KByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_68:       equ $-scachetlb_68
    scachetlb_6a:           dw len_scachetlb_6a
                            db "  uTLB: 4 KByte pages, 8-way set associative, 64 entries",0x0a
    len_scachetlb_6a:       equ $-scachetlb_6a
    scachetlb_6b:           dw len_scachetlb_6b
                            db "  DTLB: 4 KByte pages, 8-way set associative, 256 entries",0x0a
    len_scachetlb_6b:       equ $-scachetlb_6b
    scachetlb_6c:           dw len_scachetlb_6c
                            db "  DTLB: 2M/4M pages, 8-way set associative, 128 entries",0x0a
    len_scachetlb_6c:       equ $-scachetlb_6c
    scachetlb_6d:           dw len_scachetlb_6d
                            db "  DTLB: 1 GByte pages, fully associative, 16 entries",0x0a
    len_scachetlb_6d:       equ $-scachetlb_6d
    scachetlb_70:           dw len_scachetlb_70
                            db "  Trace cache: 12 K-μop, 8-way set associative",0x0a
    len_scachetlb_70:       equ $-scachetlb_70
    scachetlb_71:           dw len_scachetlb_71
                            db "  Trace cache: 16 K-μop, 8-way set associative",0x0a
    len_scachetlb_71:       equ $-scachetlb_71
    scachetlb_72:           dw len_scachetlb_72
                            db "  Trace cache: 32 K-μop, 8-way set associative",0x0a
    len_scachetlb_72:       equ $-scachetlb_72
    scachetlb_76:           dw len_scachetlb_76
                            db "  Instruction TLB: 2M/4M pages, fully associative, 8 entries",0x0a
    len_scachetlb_76:       equ $-scachetlb_76
    scachetlb_78:           dw len_scachetlb_78
                            db "  2nd-level cache: 1 MByte, 4-way set associative, 64byte line size",0x0a
    len_scachetlb_78:       equ $-scachetlb_78
    scachetlb_79:           dw len_scachetlb_79
                            db "  2nd-level cache: 128 KByte, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_79:       equ $-scachetlb_79
    scachetlb_7a:           dw len_scachetlb_7a
                            db "  2nd-level cache: 256 KByte, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_7a:       equ $-scachetlb_7a
    scachetlb_7b:           dw len_scachetlb_7b
                            db "  2nd-level cache: 512 KByte, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_7b:       equ $-scachetlb_7b
    scachetlb_7c:           dw len_scachetlb_7c
                            db "  2nd-level cache: 1 MByte, 8-way set associative, 64 byte line size, 2 lines per sector",0x0a
    len_scachetlb_7c:       equ $-scachetlb_7c
    scachetlb_7d:           dw len_scachetlb_7d
                            db "  2nd-level cache: 2 MByte, 8-way set associative, 64byte line size",0x0a
    len_scachetlb_7d:       equ $-scachetlb_7d
    scachetlb_7f:           dw len_scachetlb_7f
                            db "  2nd-level cache: 512 KByte, 2-way set associative, 64-byte line size",0x0a
    len_scachetlb_7f:       equ $-scachetlb_7f
    scachetlb_80:           dw len_scachetlb_80
                            db "  2nd-level cache: 512 KByte, 8-way set associative, 64-byte line size",0x0a
    len_scachetlb_80:       equ $-scachetlb_80
    scachetlb_82:           dw len_scachetlb_82
                            db "  2nd-level cache: 256 KByte, 8-way set associative, 32 byte line size",0x0a
    len_scachetlb_82:       equ $-scachetlb_82
    scachetlb_83:           dw len_scachetlb_83
                            db "  2nd-level cache: 512 KByte, 8-way set associative, 32 byte line size",0x0a
    len_scachetlb_83:       equ $-scachetlb_83
    scachetlb_84:           dw len_scachetlb_84
                            db "  2nd-level cache: 1 MByte, 8-way set associative, 32 byte line size",0x0a
    len_scachetlb_84:       equ $-scachetlb_84
    scachetlb_85:           dw len_scachetlb_85
                            db "  2nd-level cache: 2 MByte, 8-way set associative, 32 byte line size",0x0a
    len_scachetlb_85:       equ $-scachetlb_85
    scachetlb_86:           dw len_scachetlb_86
                            db "  2nd-level cache: 512 KByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_86:       equ $-scachetlb_86
    scachetlb_87:           dw len_scachetlb_87
                            db "  2nd-level cache: 1 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_87:       equ $-scachetlb_87
    scachetlb_a0:           dw len_scachetlb_a0
                            db "  2nd-level cache: 1 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_a0:       equ $-scachetlb_a0
    scachetlb_b0:           dw len_scachetlb_b0
                            db "  Instruction TLB: 4 KByte pages, 4-way set associative, 128 entries",0x0a
    len_scachetlb_b0:       equ $-scachetlb_b0
    scachetlb_b1:           dw len_scachetlb_b1
                            db "  Instruction TLB: 2M pages, 4-way, 8 entries or 4M pages, 4-way, 4 entries",0x0a
    len_scachetlb_b1:       equ $-scachetlb_b1
    scachetlb_b2:           dw len_scachetlb_b2
                            db "  Instruction TLB: 4KByte pages, 4-way set associative, 64 entries",0x0a
    len_scachetlb_b2:       equ $-scachetlb_b2
    scachetlb_b3:           dw len_scachetlb_b3
                            db "  Data TLB: 4 KByte pages, 4-way set associative, 128 entries",0x0a
    len_scachetlb_b3:       equ $-scachetlb_b3
    scachetlb_b4:           dw len_scachetlb_b4
                            db "  Data TLB1: 4 KByte pages, 4-way associative, 256 entries",0x0a
    len_scachetlb_b4:       equ $-scachetlb_b4
    scachetlb_b5:           dw len_scachetlb_b5
                            db "  Instruction TLB: 4KByte pages, 8-way set associative, 64 entries",0x0a
    len_scachetlb_b5:       equ $-scachetlb_b5
    scachetlb_b6:           dw len_scachetlb_b6
                            db "  Instruction TLB: 4KByte pages, 8-way set associative, 128 entries",0x0a
    len_scachetlb_b6:       equ $-scachetlb_b6
    scachetlb_ba:           dw len_scachetlb_ba
                            db "  Data TLB1: 4 KByte pages, 4-way associative, 64 entries",0x0a
    len_scachetlb_ba:       equ $-scachetlb_ba
    scachetlb_c0:           dw len_scachetlb_c0
                            db "  Data TLB: 4 KByte and 4 MByte pages, 4-way associative, 8 entries",0x0a
    len_scachetlb_c0:       equ $-scachetlb_c0
    scachetlb_c1:           dw len_scachetlb_c1
                            db "  Shared 2nd-Level TLB: 4 KByte/2MByte pages, 8-way associative, 1024 entries",0x0a
    len_scachetlb_c1:       equ $-scachetlb_c1
    scachetlb_c2:           dw len_scachetlb_c2
                            db "  DTLB: 4 KByte/2 MByte pages, 4-way associative, 16 entries",0x0a
    len_scachetlb_c2:       equ $-scachetlb_c2
    scachetlb_c3:           dw len_scachetlb_c3
                            db "  Shared 2nd-Level TLB: 4 KByte /2 MByte pages, 6-way associative, 1536 entries. Also 1GBbyte pages, 4-way, 16 entries.",0x0a
    len_scachetlb_c3:       equ $-scachetlb_c3
    scachetlb_c4:           dw len_scachetlb_c4
                            db "  DTLB: 2M/4M Byte pages, 4-way associative, 32 entries",0x0a
    len_scachetlb_c4:       equ $-scachetlb_c4
    scachetlb_ca:           dw len_scachetlb_ca
                            db "  Shared 2nd-Level TLB: 4 KByte pages, 4-way associative, 512 entries",0x0a
    len_scachetlb_ca:       equ $-scachetlb_ca
    scachetlb_d0:           dw len_scachetlb_d0
                            db "  3rd-level cache: 512 KByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_d0:       equ $-scachetlb_d0
    scachetlb_d1:           dw len_scachetlb_d1
                            db "  3rd-level cache: 1 MByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_d1:       equ $-scachetlb_d1
    scachetlb_d2:           dw len_scachetlb_d2
                            db "  3rd-level cache: 2 MByte, 4-way set associative, 64 byte line size",0x0a
    len_scachetlb_d2:       equ $-scachetlb_d2
    scachetlb_d6:           dw len_scachetlb_d6
                            db "  3rd-level cache: 1 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_d6:       equ $-scachetlb_d6
    scachetlb_d7:           dw len_scachetlb_d7
                            db "  3rd-level cache: 1 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_d7:       equ $-scachetlb_d7
    scachetlb_d8:           dw len_scachetlb_d8
                            db "  3rd-level cache: 4 MByte, 8-way set associative, 64 byte line size",0x0a
    len_scachetlb_d8:       equ $-scachetlb_d8
    scachetlb_dc:           dw len_scachetlb_dc
                            db "  3rd-level cache: 1.5 MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_dc:       equ $-scachetlb_dc
    scachetlb_dd:           dw len_scachetlb_dd
                            db "  3rd-level cache: 3 MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_dd:       equ $-scachetlb_dd
    scachetlb_de:           dw len_scachetlb_de
                            db "  3rd-level cache: 6 MByte, 12-way set associative, 64 byte line size",0x0a
    len_scachetlb_de:       equ $-scachetlb_de
    scachetlb_e2:           dw len_scachetlb_e2
                            db "  3rd-level cache: 2 MByte, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_e2:       equ $-scachetlb_e2
    scachetlb_e3:           dw len_scachetlb_e3
                            db "  3rd-level cache: 4 MByte, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_e3:       equ $-scachetlb_e3
    scachetlb_e4:           dw len_scachetlb_e4
                            db "  3rd-level cache: 8 MByte, 16-way set associative, 64 byte line size",0x0a
    len_scachetlb_e4:       equ $-scachetlb_e4
    scachetlb_ea:           dw len_scachetlb_ea
                            db "  3rd-level cache: 12MByte, 24-way set associative, 64 byte line size",0x0a
    len_scachetlb_ea:       equ $-scachetlb_ea
    scachetlb_eb:           dw len_scachetlb_eb
                            db "  3rd-level cache: 12MByte, 24-way set associative, 64 byte line size",0x0a
    len_scachetlb_eb:       equ $-scachetlb_eb
    scachetlb_ec:           dw len_scachetlb_ec
                            db "  3rd-level cache: 12MByte, 24-way set associative, 64 byte line size",0x0a
    len_scachetlb_ec:       equ $-scachetlb_ec
    scachetlb_f0:           dw len_scachetlb_f0
                            db "  64-Byte prefetching",0x0a
    len_scachetlb_f0:       equ $-scachetlb_f0
    scachetlb_f1:           dw len_scachetlb_f1
                            db "  128-Byte prefetching",0x0a
    len_scachetlb_f1:       equ $-scachetlb_f1
    scachetlb_fe:           dw len_scachetlb_fe
                            db "  CPUID leaf 2 does not report TLB descriptor information; use CPUID leaf 18H to query TLB and other address translation parameters.",0x0a
    len_scachetlb_fe:       equ $-scachetlb_fe
    scachetlb_ff:           dw len_scachetlb_ff
                            db "  CPUID leaf 2 does not report cache descriptor information, use CPUID leaf 4 to query cache parameters",0x0a
    len_scachetlb_ff:       equ $-scachetlb_ff
    cachetlb_lookup:        dq scachetlb_00 ; 0x00
                            dq scachetlb_01 ; 0x01
                            dq scachetlb_02 ; 0x02
                            dq scachetlb_03 ; 0x03
                            dq scachetlb_04 ; 0x04
                            dq scachetlb_05 ; 0x05
                            dq scachetlb_06 ; 0x06
                            dq scachetlb_00 ; 0x07
                            dq scachetlb_08 ; 0x08
                            dq scachetlb_09 ; 0x09
                            dq scachetlb_0a ; 0x0a
                            dq scachetlb_0b ; 0x0b
                            dq scachetlb_0c ; 0x0c
                            dq scachetlb_0d ; 0x0d
                            dq scachetlb_0e ; 0x0e
                            dq scachetlb_00 ; 0x0f
                            dq scachetlb_00 ; 0x10
                            dq scachetlb_00 ; 0x11
                            dq scachetlb_00 ; 0x12
                            dq scachetlb_00 ; 0x13
                            dq scachetlb_00 ; 0x14
                            dq scachetlb_00 ; 0x15
                            dq scachetlb_00 ; 0x16
                            dq scachetlb_00 ; 0x17
                            dq scachetlb_00 ; 0x18
                            dq scachetlb_00 ; 0x19
                            dq scachetlb_00 ; 0x1a
                            dq scachetlb_00 ; 0x1b
                            dq scachetlb_00 ; 0x1c
                            dq scachetlb_1d ; 0x1d
                            dq scachetlb_00 ; 0x1e
                            dq scachetlb_00 ; 0x1f
                            dq scachetlb_00 ; 0x20
                            dq scachetlb_21 ; 0x21
                            dq scachetlb_22 ; 0x22
                            dq scachetlb_23 ; 0x23
                            dq scachetlb_24 ; 0x24
                            dq scachetlb_25 ; 0x25
                            dq scachetlb_00 ; 0x26
                            dq scachetlb_00 ; 0x27
                            dq scachetlb_00 ; 0x28
                            dq scachetlb_29 ; 0x29
                            dq scachetlb_00 ; 0x2a
                            dq scachetlb_00 ; 0x2b
                            dq scachetlb_2c ; 0x2c
                            dq scachetlb_00 ; 0x2d
                            dq scachetlb_00 ; 0x2e
                            dq scachetlb_00 ; 0x2f
                            dq scachetlb_30 ; 0x30
                            dq scachetlb_00 ; 0x31
                            dq scachetlb_00 ; 0x32
                            dq scachetlb_00 ; 0x33
                            dq scachetlb_00 ; 0x34
                            dq scachetlb_00 ; 0x35
                            dq scachetlb_00 ; 0x36
                            dq scachetlb_00 ; 0x37
                            dq scachetlb_00 ; 0x38
                            dq scachetlb_00 ; 0x39
                            dq scachetlb_00 ; 0x3a
                            dq scachetlb_00 ; 0x3b
                            dq scachetlb_00 ; 0x3c
                            dq scachetlb_00 ; 0x3d
                            dq scachetlb_00 ; 0x3e
                            dq scachetlb_00 ; 0x3f
                            dq scachetlb_40 ; 0x40
                            dq scachetlb_41 ; 0x41
                            dq scachetlb_42 ; 0x42
                            dq scachetlb_43 ; 0x43
                            dq scachetlb_44 ; 0x44
                            dq scachetlb_45 ; 0x45
                            dq scachetlb_46 ; 0x46
                            dq scachetlb_47 ; 0x47
                            dq scachetlb_48 ; 0x48
                            dq scachetlb_49 ; 0x49
                            dq scachetlb_4a ; 0x4a
                            dq scachetlb_4b ; 0x4b
                            dq scachetlb_4c ; 0x4c
                            dq scachetlb_4d ; 0x4d
                            dq scachetlb_4e ; 0x4e
                            dq scachetlb_4f ; 0x4f
                            dq scachetlb_50 ; 0x50
                            dq scachetlb_51 ; 0x51
                            dq scachetlb_52 ; 0x52
                            dq scachetlb_00 ; 0x53
                            dq scachetlb_00 ; 0x54
                            dq scachetlb_55 ; 0x55
                            dq scachetlb_56 ; 0x56
                            dq scachetlb_57 ; 0x57
                            dq scachetlb_00 ; 0x58
                            dq scachetlb_59 ; 0x59
                            dq scachetlb_5a ; 0x5a
                            dq scachetlb_5b ; 0x5b
                            dq scachetlb_5c ; 0x5c
                            dq scachetlb_5d ; 0x5d
                            dq scachetlb_00 ; 0x5e
                            dq scachetlb_00 ; 0x5f
                            dq scachetlb_60 ; 0x60
                            dq scachetlb_61 ; 0x61
                            dq scachetlb_00 ; 0x62
                            dq scachetlb_63 ; 0x63
                            dq scachetlb_64 ; 0x64
                            dq scachetlb_00 ; 0x65
                            dq scachetlb_66 ; 0x66
                            dq scachetlb_67 ; 0x67
                            dq scachetlb_68 ; 0x68
                            dq scachetlb_00 ; 0x69
                            dq scachetlb_6a ; 0x6a
                            dq scachetlb_6b ; 0x6b
                            dq scachetlb_6c ; 0x6c
                            dq scachetlb_6d ; 0x6d
                            dq scachetlb_00 ; 0x6e
                            dq scachetlb_00 ; 0x6f
                            dq scachetlb_70 ; 0x70
                            dq scachetlb_71 ; 0x71
                            dq scachetlb_72 ; 0x72
                            dq scachetlb_00 ; 0x73
                            dq scachetlb_00 ; 0x74
                            dq scachetlb_00 ; 0x75
                            dq scachetlb_76 ; 0x76
                            dq scachetlb_00 ; 0x77
                            dq scachetlb_78 ; 0x78
                            dq scachetlb_79 ; 0x79
                            dq scachetlb_7a ; 0x7a
                            dq scachetlb_7b ; 0x7b
                            dq scachetlb_7c ; 0x7c
                            dq scachetlb_7d ; 0x7d
                            dq scachetlb_00 ; 0x7e
                            dq scachetlb_7f ; 0x7f
                            dq scachetlb_80 ; 0x80
                            dq scachetlb_00 ; 0x81
                            dq scachetlb_82 ; 0x82
                            dq scachetlb_83 ; 0x83
                            dq scachetlb_84 ; 0x84
                            dq scachetlb_85 ; 0x85
                            dq scachetlb_86 ; 0x86
                            dq scachetlb_87 ; 0x87
                            dq scachetlb_00 ; 0x88
                            dq scachetlb_00 ; 0x89
                            dq scachetlb_00 ; 0x8a
                            dq scachetlb_00 ; 0x8b
                            dq scachetlb_00 ; 0x8c
                            dq scachetlb_00 ; 0x8d
                            dq scachetlb_00 ; 0x8e
                            dq scachetlb_00 ; 0x8f
                            dq scachetlb_00 ; 0x90
                            dq scachetlb_00 ; 0x91
                            dq scachetlb_00 ; 0x92
                            dq scachetlb_00 ; 0x93
                            dq scachetlb_00 ; 0x94
                            dq scachetlb_00 ; 0x95
                            dq scachetlb_00 ; 0x96
                            dq scachetlb_00 ; 0x97
                            dq scachetlb_00 ; 0x98
                            dq scachetlb_00 ; 0x99
                            dq scachetlb_00 ; 0x9a
                            dq scachetlb_00 ; 0x9b
                            dq scachetlb_00 ; 0x9c
                            dq scachetlb_00 ; 0x9d
                            dq scachetlb_00 ; 0x9e
                            dq scachetlb_00 ; 0x9f
                            dq scachetlb_a0 ; 0xa0
                            dq scachetlb_00 ; 0xa1
                            dq scachetlb_00 ; 0xa2
                            dq scachetlb_00 ; 0xa3
                            dq scachetlb_00 ; 0xa4
                            dq scachetlb_00 ; 0xa5
                            dq scachetlb_00 ; 0xa6
                            dq scachetlb_00 ; 0xa7
                            dq scachetlb_00 ; 0xa8
                            dq scachetlb_00 ; 0xa9
                            dq scachetlb_00 ; 0xaa
                            dq scachetlb_00 ; 0xab
                            dq scachetlb_00 ; 0xac
                            dq scachetlb_00 ; 0xad
                            dq scachetlb_00 ; 0xae
                            dq scachetlb_00 ; 0xaf
                            dq scachetlb_b0 ; 0xb0
                            dq scachetlb_b1 ; 0xb1
                            dq scachetlb_b2 ; 0xb2
                            dq scachetlb_b3 ; 0xb3
                            dq scachetlb_b4 ; 0xb4
                            dq scachetlb_b5 ; 0xb5
                            dq scachetlb_b6 ; 0xb6
                            dq scachetlb_00 ; 0xb7
                            dq scachetlb_00 ; 0xb8
                            dq scachetlb_00 ; 0xb9
                            dq scachetlb_ba ; 0xba
                            dq scachetlb_00 ; 0xbb
                            dq scachetlb_00 ; 0xbc
                            dq scachetlb_00 ; 0xbd
                            dq scachetlb_00 ; 0xbe
                            dq scachetlb_00 ; 0xbf
                            dq scachetlb_c0 ; 0xc0
                            dq scachetlb_c1 ; 0xc1
                            dq scachetlb_c2 ; 0xc2
                            dq scachetlb_c3 ; 0xc3
                            dq scachetlb_c4 ; 0xc4
                            dq scachetlb_00 ; 0xc5
                            dq scachetlb_00 ; 0xc6
                            dq scachetlb_00 ; 0xc7
                            dq scachetlb_00 ; 0xc8
                            dq scachetlb_00 ; 0xc9
                            dq scachetlb_ca ; 0xca
                            dq scachetlb_00 ; 0xcb
                            dq scachetlb_00 ; 0xcc
                            dq scachetlb_00 ; 0xcd
                            dq scachetlb_00 ; 0xce
                            dq scachetlb_00 ; 0xcf
                            dq scachetlb_d0 ; 0xd0
                            dq scachetlb_d1 ; 0xd1
                            dq scachetlb_d2 ; 0xd2
                            dq scachetlb_00 ; 0xd3
                            dq scachetlb_00 ; 0xd4
                            dq scachetlb_00 ; 0xd5
                            dq scachetlb_d6 ; 0xd6
                            dq scachetlb_d7 ; 0xd7
                            dq scachetlb_d8 ; 0xd8
                            dq scachetlb_00 ; 0xd9
                            dq scachetlb_00 ; 0xda
                            dq scachetlb_00 ; 0xdb
                            dq scachetlb_dc ; 0xdc
                            dq scachetlb_dd ; 0xdd
                            dq scachetlb_de ; 0xde
                            dq scachetlb_00 ; 0xdf
                            dq scachetlb_00 ; 0xe0
                            dq scachetlb_00 ; 0xe1
                            dq scachetlb_e2 ; 0xe2
                            dq scachetlb_e3 ; 0xe3
                            dq scachetlb_e4 ; 0xe4
                            dq scachetlb_00 ; 0xe5
                            dq scachetlb_00 ; 0xe6
                            dq scachetlb_00 ; 0xe7
                            dq scachetlb_00 ; 0xe8
                            dq scachetlb_00 ; 0xe9
                            dq scachetlb_ea ; 0xea
                            dq scachetlb_eb ; 0xeb
                            dq scachetlb_ec ; 0xec
                            dq scachetlb_00 ; 0xed
                            dq scachetlb_00 ; 0xee
                            dq scachetlb_00 ; 0xef
                            dq scachetlb_f0 ; 0xf0
                            dq scachetlb_f1 ; 0xf1
                            dq scachetlb_00 ; 0xf2
                            dq scachetlb_00 ; 0xf3
                            dq scachetlb_00 ; 0xf4
                            dq scachetlb_00 ; 0xf5
                            dq scachetlb_00 ; 0xf6
                            dq scachetlb_00 ; 0xf7
                            dq scachetlb_00 ; 0xf8
                            dq scachetlb_00 ; 0xf9
                            dq scachetlb_00 ; 0xfa
                            dq scachetlb_00 ; 0xfb
                            dq scachetlb_00 ; 0xfc
                            dq scachetlb_00 ; 0xfd
                            dq scachetlb_fe ; 0xfe
                            dq scachetlb_ff ; 0xff
    scr:                    db 0x0a

section .text
    extern prints
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
    je    check_intel
    cmp   EBX,"Auth"
    jne   unknown_vendor
    cmp   EDX,"enti"
    jne   unknown_vendor
    cmp   ECX,"cAMD"
    jne   unknown_vendor
    mov   [cpu_vendor],byte 0x01
    jmp   vendor_done
check_intel:
    cmp   EDX,"ineI"
    jne   unknown_vendor
    cmp   ECX,"ntel"
    jne   unknown_vendor
    mov   [cpu_vendor],byte 0x00
    jmp   vendor_done
unknown_vendor:
    mov   [cpu_vendor],byte 0xff

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
    jmp   done_basic

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

    mov   RSI,scacheline
    mov   RCX,len_cacheline
    rep
    movsb
    mov   RAX,R10
    shr   RAX,8
    and   RAX,0x0f
    mov   RBX,8
    mul   RBX
    call  printw
    mov   RSI,scr            ; append CR
    movsb

    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    cmp   EAX,2              ; check if node 2 is supported by CPUID
    jl    done_basic         ; if 1 is not supported we're done
    cmp   [cpu_vendor],byte 0x00 ; this is an Intel CPU
    jne   no_intel_node2
    call  intel_node2

no_intel_node2:

done_basic:
    mov   RDX,RDI            ; calculate the length of the output
    sub   RDX,output
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,output
    syscall

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
	bt    R12,23             ; test for popcnt
    jnc   no_popcnt
    mov   RSI,sfeat_popcnt
    mov   RCX,slen_feat_popcnt
    rep
    movsb
no_popcnt:
    cmp   [cpu_vendor],byte 0x00 ; test for Intel
    jne   no_tsc_deadline
	bt    R12,24             ; test for tsc_deadline
    jnc   no_tsc_deadline
    mov   RSI,sfeat_tsc_deadline
    mov   RCX,slen_feat_tsc_deadline
    rep
    movsb
no_tsc_deadline:
	bt    R12,25             ; test for aes
    jnc   no_aes
    mov   RSI,sfeat_aes
    mov   RCX,slen_feat_aes
    rep
    movsb
no_aes:
	bt    R12,26             ; test for xsave
    jnc   no_xsave
    mov   RSI,sfeat_xsave
    mov   RCX,slen_feat_xsave
    rep
    movsb
no_xsave:
	bt    R12,27             ; test for osxsave
    jnc   no_osxsave
    mov   RSI,sfeat_osxsave
    mov   RCX,slen_feat_osxsave
    rep
    movsb
no_osxsave:
	bt    R12,28             ; test for avx
    jnc   no_avx
    mov   RSI,sfeat_avx
    mov   RCX,slen_feat_avx
    rep
    movsb
no_avx:
	bt    R12,29             ; test for f16c
    jnc   no_f16c
    mov   RSI,sfeat_f16c
    mov   RCX,slen_feat_f16c
    rep
    movsb
no_f16c:
	bt    R12,30             ; test for rdrand
    jnc   no_rdrand
    mov   RSI,sfeat_rdrand
    mov   RCX,slen_feat_rdrand
    rep
    movsb
no_rdrand:
    ret

intel_node2:
    mov   RSI,scachetlb
    mov   RCX,len_scachetlb
    rep
    movsb

    mov   EAX,2              ; get the next node
    cpuid                    ; get cpu information 0x02 (Cache/TLB information)
    mov   R9,RAX             ; save Cache/TLB information (1)
    mov   R10,RBX            ; save Cache/TLB information (2)
    mov   R12,RCX            ; save Cache/TLB information (3)
    mov   R13,RDX            ; save Cache/TLB information (4)
    bt    RAX,31             ; Test information for validity
    jc    test_node2_ebx
    shr   RAX,8
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R9             ; retore Cache/TLB information (1)
    shr   RAX,16
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R9             ; retore Cache/TLB information (1)
    shr   RAX,24
    and   RAX,0xff
    call  out_cachetlb_info

test_node2_ebx:
    mov   RAX,R10            ; retore Cache/TLB information (2)
    bt    RAX,31             ; Test information for validity
    jc    test_node2_ecx
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R10            ; retore Cache/TLB information (2)
    shr   RAX,8
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R10            ; retore Cache/TLB information (2)
    shr   RAX,16
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R10            ; retore Cache/TLB information (2)
    shr   RAX,24
    and   RAX,0xff
    call  out_cachetlb_info

test_node2_ecx:
    mov   RAX,R12            ; retore Cache/TLB information (3)
    bt    RAX,31             ; Test information for validity
    jc    test_node2_edx
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R12            ; retore Cache/TLB information (3)
    shr   RAX,8
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R12            ; retore Cache/TLB information (3)
    shr   RAX,16
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R12            ; retore Cache/TLB information (3)
    shr   RAX,24
    and   RAX,0xff
    call  out_cachetlb_info

test_node2_edx:
    mov   RAX,R13            ; retore Cache/TLB information (4)
    bt    RAX,31             ; Test information for validity
    jc    test_node2_end
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R13            ; retore Cache/TLB information (4)
    shr   RAX,8
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R13            ; retore Cache/TLB information (4)
    shr   RAX,16
    and   RAX,0xff
    call  out_cachetlb_info
    mov   RAX,R13            ; retore Cache/TLB information (4)
    shr   RAX,24
    and   RAX,0xff
    call  out_cachetlb_info

test_node2_end:
    ret

;
append_string:
    xor   RCX,RCX
    ret

out_cachetlb_info:
    mov   RCX,8              ; multiply the index with the size of an address (8 byte)
    mul   RCX
    add   RAX,cachetlb_lookup ; add the lookup base address
    mov   RSI,[RAX]          ; load the string
    call  prints
    ret
