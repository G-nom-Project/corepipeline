/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { paramsSummaryMap       } from 'plugin/nf-schema'
include { softwareVersionsToYAML } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { methodsDescriptionText } from '../subworkflows/local/utils_nfcore_corepipeline_pipeline'
include { REPEATMASKER } from '../modules/local/repeatmasker/main'
include { BUSCO as BUSCO_GENOME } from '../modules/local/busco/main'
include { BUSCO as BUSCO_PROT } from '../modules/local/busco/main'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


process PUBLISH_BUSCO_SHORT_SUMMARY {
    tag "${meta.id}"

    input:
    tuple val(meta), path(summary)

    output:
    path(summary)

    script:
    """
    mkdir -p results/busco/short_summaries
    cp ${summary} results/busco/short_summaries/
    """
}

def publish_busco_short_summaries(ch) {
    ch | PUBLISH_BUSCO_SHORT_SUMMARY
}

workflow COREPIPELINE {

    take:
    fasta_ch // file path
    rmdb_ch // file path
    species_ch

    // BUSCO parameters
    busco_lineage

    // Proteins for BUSCO
    protein_fasta


    main:
    
    // First run Repeatmasker
    REPEATMASKER(
        fasta_ch,
        rmdb_ch,
        species_ch
    )
    

    ch_meta_fasta = file(params.fasta)
    ch_mode = Channel.value("genome")
    ch_lineage = Channel.value(busco_lineage)

    // Call BUSCO in genome mode
    BUSCO_GENOME(
        ch_meta_fasta,
        ch_mode,
        ch_lineage,
        [],
        []
    )

    // Call BUSCO in protein mode
    ch_mode = Channel.value("proteins")
    BUSCO_PROT(
        protein_fasta,
        ch_mode,
        ch_lineage,
        [],
        []
    )


    emit:
    BUSCO_GENOME.out.short_summaries_json
    

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
