#!/usr/bin/env nextflow

//
// MODULE IMPORT BLOCK
//
include { PRETEXT_TO_ASM  } from '../../modules/local/pretext_to_asm'
include { JUICERC         } from '../../modules/local/juicerc'
include { MAKE_HEADER     } from '../../modules/local/make_header'
include { MAKE_PAIRS      } from '../../modules/local/make_pairs'
include { PRETEXTMAP      } from '../../modules/nf-core/pretextmap/main'

workflow ZIPPYPRETEXT {
take:
    fasta // channel: fasta file to produce the mapped bam --input
    pretextagp
    hicmap
    idxfile

    main:

    ch_versions = Channel.empty()

    PRETEXT_TO_ASM (
        fasta,
        pretextagp
    )
    ch_correctedagp = PRETEXT_TO_ASM.out.correctedagp
    ch_versions = ch_versions.mix(PRETEXT_TO_ASM.out.versions.first())
    
    PRETEXT_TO_ASM.out.correctedagp.map{ agpid, agp -> agp}.set{agp}
    
    JUICERC (
    	hicmap,
    	agp,
    	idxfile
    )
	ch_alignment = JUICERC.out.alignment
    JUICERC.out.outlog.combine( fasta )
                      .map{ outlog, fa_id, fa -> 
                      tuple(
                        fa_id,
                        outlog
                        )
                        }.set{ch_outlog}
    ch_versions  = ch_versions.mix(JUICERC.out.versions.first())

    MAKE_HEADER (
        ch_outlog
    )
    MAKE_HEADER.out.header.map{ header_id, header -> header}.set{ch_header}
    ch_versions  = ch_versions.mix(MAKE_HEADER.out.versions.first())

    MAKE_PAIRS (
        ch_alignment,
        ch_header
    )
    ch_pairs = MAKE_PAIRS.out.pairs
    ch_versions  = ch_versions.mix(MAKE_PAIRS.out.versions.first())

    PRETEXTMAP (
        ch_pairs,
        [[],[],[]]
    )
    ch_map = PRETEXTMAP.out.pretext
    ch_versions  = ch_versions.mix(PRETEXTMAP.out.versions.first())

    emit:
    correctedagp   = ch_correctedagp
    alignment      = ch_alignment
    pair           = ch_pairs
    pretextmap     = ch_map
    versions       = ch_versions                 // channel: [ path(versions.yml) ]
}