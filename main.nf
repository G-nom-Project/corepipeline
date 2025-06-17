#!/usr/bin/env nextflow
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    G-nom-Project/corepipeline
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Github : https://github.com/G-nom-Project/corepipeline
----------------------------------------------------------------------------------------
*/

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { COREPIPELINE  } from './workflows/corepipeline'
include { PIPELINE_INITIALISATION } from './subworkflows/local/utils_nfcore_corepipeline_pipeline'
include { PIPELINE_COMPLETION     } from './subworkflows/local/utils_nfcore_corepipeline_pipeline'
include { getGenomeAttribute      } from './subworkflows/local/utils_nfcore_corepipeline_pipeline'


workflow GNOMPROJECT_COREPIPELINE {

    take:
    fasta
    rmdb
    species
    busco_lineage
    protein_fasta

    main:
    COREPIPELINE(
        fasta,
        rmdb,
        species,
        busco_lineage,
        protein_fasta
    )
}


workflow {

    main:

    // Convert params.* to channels
    fasta_ch = Channel.fromPath(params.fasta)
    rmdb_ch = Channel.from(params.rmdb)
    species_ch = Channel.from(params.species)
    protein_fasta_ch = Channel.fromPath(params.protein_fasta)


    GNOMPROJECT_COREPIPELINE(
        fasta_ch,
        rmdb_ch,
        species_ch,
        params.busco_lineage,
        protein_fasta_ch
    )

    PIPELINE_COMPLETION(
        params.email,
        params.email_on_fail,
        params.plaintext_email,
        params.outdir,
        params.monochrome_logs,
        params.hook_url
    )
}

