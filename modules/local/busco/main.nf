process BUSCO {
    label 'process_medium'
    publishDir "${params.outdir}/busco/${mode}/", mode: 'copy', optional: true
    conda "${moduleDir}/environment.yml"

    input:
    path(fasta, stageAs: 'tmp_input/*')
    val mode
    val lineage
    path busco_lineages_path
    path config_file

    output:
    path("busco/short_summary.*.txt"), emit: short_summaries_txt
    path("busco/short_summary.*.json"), emit: short_summaries_json
    path "versions.yml", emit: versions


    when:
    task.ext.when == null || task.ext.when

    script:
    if (mode !in ['genome', 'proteins', 'transcriptome']) {
        error("Mode must be one of 'genome', 'proteins', or 'transcriptome'.")
    }
    def busco_config = config_file ? " --config ${config_file}" : ''
    def busco_lineage_dir = busco_lineages_path ? " --download_path ${busco_lineages_path}" : ''
    
    """
    echo "BUSCO starting"

    busco --cpu ${task.cpus} --out busco --mode ${mode} -i ${fasta} -l ${lineage}${busco_lineage_dir}${busco_config}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        busco: \$( busco --version 2> /dev/null | sed 's/BUSCO //g' )
    END_VERSIONS
    """

    stub:
    def fasta_name = files(fasta).first().name - '.gz'
    """
    touch busco.batch_summary.txt
    mkdir -p busco/${fasta_name}/run_${lineage}/busco_sequences

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        busco: \$( busco --version 2> /dev/null | sed 's/BUSCO //g' )
    END_VERSIONS
    """
}
