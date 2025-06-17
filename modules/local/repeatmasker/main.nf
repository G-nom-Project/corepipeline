

process REPEATMASKER {
    tag '$fasta'
    label 'process_medium'

    conda("bioconda::repeatmasker=4.1.7p1")

    publishDir "${params.outdir}/repeatmasker", mode: 'copy'

    input:
    path fasta
    val rmdir
    val species

    output:
    path("*.masked") , emit: masked
    path(rm_gff)      , emit: gff
    path(rm_tbl)      , emit: tbl
    path(rm_out)      , emit: rm_out
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    base_name = fasta.getName()
    rm_gff = base_name + ".out.gff"
    rm_tbl = base_name + ".tbl"
    rm_out = base_name + ".out"
    def options = ""

    if (species) {
       options = "-species '$species'"
    }


    """
    LIBDIR=${rmdir} RepeatMasker $options -gff -pa ${task.cpus} $fasta

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        repeatmasker: \$(Repeatmasker --version)
    END_VERSIONS
    """

    stub:
    """
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        repeatmasker: \$(repeatmasker --version)
    END_VERSIONS
    """
}
